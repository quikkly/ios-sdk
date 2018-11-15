#pragma once

/*

Security notes
--------------
The input image can be user-provided.
As long as its width, height, format, bytes_per_row are correctly set, no
input image should crash the core lib.

The tag generation input data can be user-provided.
If the data does not fit the requested tag layout, an error will be returned.


Threading notes
---------------
The core lib can be used in parallel from multiple threads,
but each QCPipeline object, and related objects may be used only from a single thread.

If you want to process multiple frames in parallel, build multiple pipelines.
If you want to process scan results in a different thread from the image processing,
make your own copy of the result data before feeding the next frame into the pipeline.


Why extern "C"?
---------------
The public interface of the core lib must not use any C++ features, plain C only.
Plain C is easy to interface with Python, Go and all other languages.
C++ is difficult to write bindings for outside of ObjectiveC and JNI (which actually wraps everything in plain C functions for Java).
So no struct constructors (use init functions instead), no std::string or std::vector.
Internals of the core can and do use C++.


Refactoring data structures
---------------------------
If these structs are changed, make sure to add padding to keep "bigger" fields aligned to their size.
1-byte aligned to 1-byte, 4-byte aligned to 4-byte, 8-byte aligned to 8-byte, and total struct size to 8 bytes.
Otherwise Python bindings get messy, and floating point access crashes with a very confusing error on mobile ARM processors.


*/


#include <stddef.h>
#include <stdint.h>

#define QC_EXPORT __attribute__((visibility("default")))


#define QC_VERSION_STR "3.4.8"


// Greyscale, 1 byte per pixel. Array order is: row, column.
// For NV21, just use GREY_UINT8, its grayscale channel comes first in memory, and the color channels will be ignored.
#define QC_IMAGE_FORMAT_GREY_UINT8  0
#define QC_IMAGE_FORMAT_BGRA_UINT32 1
#define QC_IMAGE_FORMAT_RGBA_UINT32 2
#define QC_IMAGE_FORMAT_NV21_UINT8  3  // Input byte buffer must be 1.5 * height rows!

#define QC_OK 0


#define QC_IMAGE_FIT_DEFAULT 0  // Use template default
#define QC_IMAGE_FIT_STRETCH 1  // Stretch in both dimensions
#define QC_IMAGE_FIT_MEET    2  // Fit and center inside the viewbox, keep proportions. May leave empty space around image.
#define QC_IMAGE_FIT_SLICE   3  // Fit and center to fill entire viewbox, keep proportions. May crop edges of the image.


// Values for join parameter in skin. Can be added (= bitwise ORed) together.
#define QC_JOIN_DEFAULT       -1  // Template default join.
#define QC_JOIN_NONE           0  // No join, independent dots.
#define QC_JOIN_HORIZONTAL     1  // Horizontal, or along the circles for circular tags.
#define QC_JOIN_VERTICAL       2
#define QC_JOIN_DIAGONAL_RIGHT 4  // diagonal BL-TR: /.
#define QC_JOIN_DIAGONAL_LEFT  8  // diagonal BR-TL: \.
#define QC_JOIN_MAX           16  // Sum of all join constants, do not use.


#define QC_SCAN_STATUS_UNKNOWN             0
#define QC_SCAN_STATUS_NO_FRAME_SCANNED    10
#define QC_SCAN_STATUS_NO_SHAPES_FOUND     100
#define QC_SCAN_STATUS_SHAPE_FOUND         200
#define QC_SCAN_STATUS_DOTS_FOUND          300
#define QC_SCAN_STATUS_SUCCESS             10000
#define QC_SCAN_STATUS_MAX                 99999


typedef void _QCPipeline;


#ifdef __cplusplus
extern "C" {
#endif


// Part of a successful scan result.
struct _QCTag {
    uint64_t data;     // Tag ID decoded from the image.
    char * type;       // Name of the final step in the processing pipeline that produced the tag.
                       // Lifetime is managed by the core lib - do not access after calling qc_release_result() on this result, or qc_release_pipeline().
    float corners[8];  // Corners of the box in [0...1] coordinates relative to image size. May be all zeros if not provided by the algorithm. Pairs of (x, y) in order TL, TR, BR, BL. 0 is top/left, 1 is bottom/right.
    float area;        // Area of the tag roughly as a proportion of the image size. May be zero if not provided by the algorithm.
    float _pad;        // Keep structure size a multiple of 8 bytes.
} __attribute__ ((aligned(8)));
typedef struct _QCTag QCTag;


// QCScanResult is allocated by qc_alloc_extract_result().
// You can access the data until a matching qc_release_result() call.
struct _QCScanResult {
    QCTag * tags;
    uint8_t * status_image;  // May be null
    int32_t num_tags;
    int32_t status_code;
} __attribute__ ((aligned(8)));
typedef struct _QCScanResult QCScanResult;


// QCSkin is used to provide a visual theme to the SVG tag generator.
// Allocate one yourself, and fill it with appropriate values.
// The values are inserted directly into the SVG template XML without escaping.
// If the data comes from the user, ensure that it is validated for correctness before passing it into the scanner.
struct _QCSkin {
    const char * border_color;      // Color as a string: CSS name, #aabbcc hex, or rgb() triple.
    const char * background_color;  // Color as a string: CSS name, #aabbcc hex, or rgb() triple.
    const char * mask_color;        // Color as a string: CSS name, #aabbcc hex, or rgb() triple.
    const char * overlay_color;     // Color as a string: CSS name, #aabbcc hex, or rgb() triple.
    const char * image_url;         // Image URL or embedded raw data "URL" like "data:image/png;base64,..."
    const char * logo_url;          // Logo URL or embedded raw data "URL" like "data:image/png;base64,..."
    const char ** data_colors;      // Array of colors as a string: CSS name, #aabbcc hex, or rgb() triple.
    int32_t     num_data_colors;
    int32_t     image_fit;          // One of the QC_IMAGE_FIT constants.
    int32_t     logo_fit;           // One of the QC_IMAGE_FIT constants.
    int32_t     join;               // Sum of QC_JOIN constants, or -1 for "template default".
    int32_t     _pad;
} __attribute__ ((aligned(8)));
typedef struct _QCSkin QCSkin;


// Get version string.
const char * qc_version_str(void);
// Parse version string.
void qc_version(int * out_major, int * out_minor, int * out_patch);


// Returns 1 if this is a QC_DEBUG-enabled build.
uint8_t qc_debug(void);

// Checks that all libraries have been linked correctly, and returns library version on success.
// Returns NULL for errors.
const char * qc_check_linking(void);

// Build a scanning pipeline out of the specification of stages and parameters in the blueprint.
_QCPipeline* qc_alloc_build_pipeline(const char* blueprint);
void qc_release_pipeline(_QCPipeline* pipeline);

// Get info on loaded templates
uint32_t qc_num_templates(const _QCPipeline* const pipeline);
const char * qc_template_identifier(const _QCPipeline* const pipeline, uint32_t template_index);

// Returns 0 on success (even if no tag was found), other numbers based on OpenCV exception error codes.
int32_t qc_process_frame(
    _QCPipeline* pipeline,
    const uint8_t* const input,               // Bytes for the input image.
    int32_t format,                           // One of the format defines.
    int32_t width,                            // Height of the input image in pixels.
    int32_t height,                           // Width of the input image in pixels. For NV21 format, actual height of the byte buffer must be 1.5x larger.
    int32_t bytes_per_row                     // Usually width for GREY_UINT8, and width*4 for XXXA_UINT32. May be larger if image rows have padding in memory.
                                              // Pass -1 to have it automatically computed from width * format.
);

// Allocates a new QCScanResult, and fills it with data from the last processed frame from the pipeline.
QCScanResult* qc_alloc_extract_result(const _QCPipeline* const pipeline, uint8_t return_status_image);
void qc_release_result(QCScanResult * result);

// Generate new tags.
void qc_init_default_skin(QCSkin * skin);
uint8_t qc_template_exists(const _QCPipeline* const pipeline, const char * type);
uint64_t qc_max_data_value(const _QCPipeline* const pipeline, const char * type);
char* qc_alloc_generate_svg(const _QCPipeline* const pipeline, const char * type, uint64_t data, const QCSkin * skin);
void qc_release_svg(char* svg);

// Debug image calls are available only if the library is compiled with QC_DEBUG enabled.
int32_t qc_num_debug_images(const _QCPipeline* const pipeline, const char * type);
uint8_t * qc_access_debug_image(const _QCPipeline* const pipeline, const char * type, int32_t image_idx, int32_t * out_format, int32_t * out_width, int32_t * out_height);
double qc_access_debug_seconds(const _QCPipeline* const pipeline, const char * step_method);


#ifdef __cplusplus
}  // extern "C"
#endif
