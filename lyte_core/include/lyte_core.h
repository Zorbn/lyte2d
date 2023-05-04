#ifndef LYTE_CORE_H_INCLUDED
#define LYTE_CORE_H_INCLUDED

#include "api_generated.h" // types and enums

#ifndef MIN
#define MIN(a,b) (((a)<(b))?(a):(b))
#endif

#ifndef MAX
#define MAX(a,b) (((a)>(b))?(a):(b))
#endif

#ifndef M_PI
#define M_PI  3.14159265358979323846264f
#endif


// -------------------------
// core_state
// -------------------------

typedef struct lyte_State {
    lyte_BlendMode default_blendmode;
    lyte_BlendMode default_filtermode;

    bool vsync;
    lyte_BlendMode blendmode;
    lyte_FilterMode filtermode;

} lyte_State;

extern lyte_State lyte_state;

void lyte_core_state_init(bool vsync, lyte_BlendMode default_blendmode, lyte_FilterMode default_filtermode);

// -------------------------
// core_image
// -------------------------


void lyte_core_image_init(void);
void lyte_core_image_cleanup(void);

int lyte_load_image(const char *path, lyte_Image *img);
int lyte_new_canvas(int w, int h, lyte_Image *img);
int lyte_cleanup_image(lyte_Image image);

int lyte_get_image_width(lyte_Image image, int *val);
int lyte_get_image_height(lyte_Image image, int *val);
int lyte_draw_image(lyte_Image image, int x, int y);
int lyte_draw_image_rect(lyte_Image image, int x, int y, int src_x, int src_y, int w, int h);
int lyte_set_canvas(lyte_Image image);
int lyte_reset_canvas(void);
int lyte_is_image_canvas(lyte_Image image, bool *val);


// -------------------------
// core_shapes
// -------------------------

int lyte_draw_point(int x, int y);
int lyte_draw_line(int x1, int y1, int x2, int y2);
int lyte_draw_rect(int dest_x, int dest_y, int rect_width, int rect_height);
int lyte_draw_rect_line(int dest_x, int dest_y, int rect_width, int rect_height);
int lyte_draw_circle(int dest_x, int dest_y, int radius);
int lyte_draw_circle_line(int dest_x, int dest_y, int radius);

// -------------------------
// core_audio
// -------------------------

// lifetime
void lyte_core_audio_init(void);
void lyte_core_audio_cleanup(void);
void lyte_core_audio_update_music_streams(void); // needs to run each frame

// general
int lyte_get_mastervolume(double *vol);
int lyte_set_mastervolume(double vol);

// music
int lyte_load_music(const char *path, lyte_Music *mus);
int lyte_cleanup_music(lyte_Music mus);

int lyte_play_music(lyte_Music mus);
int lyte_pause_music(lyte_Music mus);
int lyte_resume_music(lyte_Music mus);
int lyte_stop_music(lyte_Music mus);
int lyte_is_music_playing(lyte_Music mus, bool *val);
int lyte_get_music_volume(lyte_Music mus, double *val);
int lyte_get_music_pan(lyte_Music mus, double *val);
int lyte_get_music_pitch(lyte_Music mus, double *val);
int lyte_get_music_length(lyte_Music mus, double *secs);
int lyte_get_music_length_played(lyte_Music mus, double *secs);
int lyte_set_music_volume(lyte_Music mus, double vol);
int lyte_set_music_pan(lyte_Music mus, double pan);
int lyte_set_music_pitch(lyte_Music mus, double pitch);
int lyte_seek_music(lyte_Music mus, double secs);

// sound
int lyte_load_sound(const char * sound_path, lyte_Sound *val);
int lyte_clone_sound(lyte_Sound orig, lyte_Sound *val);
int lyte_cleanup_sound(lyte_Sound sound);

int lyte_play_sound(lyte_Sound snd);
int lyte_pause_sound(lyte_Sound snd);
int lyte_resume_sound(lyte_Sound snd);
int lyte_stop_sound(lyte_Sound snd);
int lyte_is_sound_playing(lyte_Sound snd, bool *val);
int lyte_get_sound_volume(lyte_Sound snd, double *val);
int lyte_get_sound_pan(lyte_Sound snd, double *val);
int lyte_get_sound_pitch(lyte_Sound snd, double *val);
int lyte_set_sound_volume(lyte_Sound snd, double volume);
int lyte_set_sound_pan(lyte_Sound snd, double pan);
int lyte_set_sound_pitch(lyte_Sound snd, double pitch);


// -------------------------
// core_font
// -------------------------

void lyte_core_font_init(void);
void lyte_core_font_cleanup(void);

int lyte_load_font(const char * font_path, double size, lyte_Font *val);
int lyte_cleanup_font(lyte_Font font);

int lyte_set_font(lyte_Font font);
int lyte_draw_text(const char * text, int dest_x, int dest_y);
int lyte_get_text_width(const char * text, int *val);
int lyte_get_text_height(const char * text, int *val);


// -------------------------
// core_shader
// -------------------------


// ShaderBuilder
int lyte_new_shaderbuilder(lyte_ShaderBuilder *val);
int lyte_cleanup_shaderbuilder(lyte_ShaderBuilder shaderbuilder);

int lyte_shaderbuilder_uniform(lyte_ShaderBuilder shaderbuilder, const char * uniform_name, lyte_UniformType uniform_type);
int lyte_shaderbuilder_vertex(lyte_ShaderBuilder shaderbuilder, const char * vertex_code);
int lyte_shaderbuilder_fragment(lyte_ShaderBuilder shaderbuilder, const char * fragment_code);

// Shader
 int lyte_shaderbuilder_build(lyte_ShaderBuilder shaderbuilder, lyte_Shader *shader);
 int lyte_cleanup_shader(lyte_Shader shader);

 int lyte_set_shader(lyte_Shader shader);
 int lyte_reset_shader(void);
 int lyte_send_shader_uniform(lyte_Shader shader, const char * uniform_name, lyte_ShaderUniformValue uniform_value, int which_uniform_value);



#endif  // LYTE_CORE_H_INCLUDED