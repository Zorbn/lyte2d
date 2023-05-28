---------------------------------------------------------------------------------------------
-- LYTE API -- source of truth for the API
---------------------------------------------------------------------------------------------

local apidef = require "lib.apidef"

local String = apidef.String
local Integer = apidef.Integer
local Float = apidef.Float
local Number = apidef.Number
local Boolean = apidef.Boolean
local Nil = apidef.Nil
local Type = apidef.Type
local Record = apidef.Record
local Namespace = apidef.Namespace
local Field = apidef.Field
local OneOf = apidef.OneOf
local Option = apidef.Option
local Enum = apidef.Enum
local Dict = apidef.Dict
local List = apidef.List
local Function = apidef.Function
local Method = apidef.Method
local Arg = apidef.Arg
local Ret = apidef.Ret
local Alias = apidef.Alias

---------------------------------------------------------------------------------------------
-- Definitions
---------------------------------------------------------------------------------------------

return Namespace("lyte", {
    Function("tick", {
        Arg("delta_time", Number(), {optional=true, default=0.0}),
        Arg("window_width", Integer(), {optional=true, default=0.0}),
        Arg("window_height", Integer(), {optional=true, default=0.0}),
        Arg("window_resized", Boolean(), {optional=true, default=false}),
    }, nil, {d="Tick function. Should be created by the user.", c_api_skip=true}),

    Function("quit", nil, nil, {d="Quit the application by closing the window."}),

    Function("cls", {
        Arg("r", Number()),
        Arg("g", Number()),
        Arg("b", Number()),
        Arg("a", Number()),
    }, nil, {d="Clear the screen or current canvas if one is used."}),

    Function("set_color", {
        Arg("r", Number()),
        Arg("g", Number()),
        Arg("b", Number()),
        Arg("a", Number()),
    }, nil, {d="Set the foreground color to be used in the drawing operations."}),

    Function("reset_color", nil, nil, {d="Reset the color to its default value."}),

    Function("draw_point", {
        Arg("x", Integer()),
        Arg("y", Integer()),
    }, nil, {d="Draw a point."}),

    Function("draw_line", {
        Arg("x1", Integer()),
        Arg("y1", Integer()),
        Arg("x2", Integer()),
        Arg("y2", Integer()),
    }, nil, {d="Draw a line"}),

    Function("draw_rect", {
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
        Arg("rect_width", Integer()),
        Arg("rect_height", Integer()),
    }, nil, {d="Draw a filled rectangle."}),

    Function("draw_rect_line", {
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
        Arg("rect_width", Integer()),
        Arg("rect_height", Integer()),
    }, nil, {d="Draw a rectangle border."}),

    Function("draw_circle", {
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
        Arg("radius", Integer()),
    }, nil, {d="Draw a filled circle."}),

    Function("draw_circle_line", {
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
        Arg("radius", Integer()),
    }, nil, {d="Draw a circle border."}),

    Function("load_image", {
        Arg("image_path", String()),
    },{
        Ret("val", Type("Image"), {nativetype="udata"}),
    }, {d="Load the image specified in the path.", ctor=true}),

    Function("draw_image", {
        Arg("image", Type("Image"), {nativetype="udata"}),
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
    }, nil, {d="Draw an image."}),

    Function("draw_image_rect", {
        Arg("image", Type("Image"), {nativetype="udata"}),
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
        Arg("src_x", Integer()),
        Arg("src_y", Integer()),
        Arg("rect_width", Integer()),
        Arg("rect_height", Integer()),
    }, nil, {d="Draw a rectangular area from the image."}),

    Function("get_image_width", {
        Arg("image", Type("Image"), {nativetype="udata"}),
    }, {
        Ret("val", Integer()),
    }, {d="Get the width of the image."}),

    Function("get_image_height",  {
        Arg("image", Type("Image"), {nativetype="udata"}),
    }, {
        Ret("val", Integer()),
    }, {d="Get the height of the image."}),

    Function("new_canvas", {
        Arg("width", Integer()),
        Arg("height", Integer()),
    },{
        Ret("val", Type("Image"), {nativetype="udata"}),
    }, {d="Create a canvas image with given width and height.", ctor=true}),

    Function("set_canvas", {
        Arg("canvas_image", Type("Image"), {nativetype="udata", save_to_registry=true}),
    }, nil, {d="Set the effective canvas image. All draw operations will go to this canvas until it's reset."}),

    Function("reset_canvas", nil, nil, {d="Reset the drawing target, back to screen."}),

    Function("is_image_canvas",  {
        Arg("image", Type("Image"), {nativetype="udata"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the image was created as a canvas."}),

    Function("load_font", {
        Arg("font_path", String()),
        Arg("size", Number()),
    },{
        Ret("val", Type("Font"), {nativetype="udata"}),
    }, {d="Load the font specified in the path, and set the initial size.", ctor=true}),

    Function("set_font", {
        Arg("font", Type("Font"), {nativetype="udata", save_to_registry=true}),
    }, nil, {d="Set the effective font to be used in the drawing operations."}),

    Function("reset_font", nil, nil, {d="Reset the font to its default value.", c_api_skip=true}),

    Function("draw_text", {
        Arg("text", String()),
        Arg("dest_x", Integer()),
        Arg("dest_y", Integer()),
    }, nil, {d="Draw a text line."}),

    Function("get_text_width", {
        Arg("text", String()),
    }, {
        Ret("val", Integer()),
    }, {d="Get the width of the given text line."}),

    Function("get_text_height", {
        Arg("text", String()),
    }, {
        Ret("val", Integer()),
    }, {d="Get the height of the given text line."}),

    Function("set_window_minsize", {
        Arg("width", Integer()),
        Arg("height", Integer()),
    }, nil, {d="Set the window's minimum possible size."}),

    Function("set_window_size", {
        Arg("width", Integer()),
        Arg("height", Integer()),
    }, nil, {d="Set the window's size."}),

    Function("get_window_width", nil, {
        Ret("val", Integer()),
    }, {d="Get the width of the window."}),

    Function("get_window_height", nil, {
        Ret("val", Integer()),
    }, {d="Get the height of the window."}),

    Function("set_fullscreen", {
        Arg("fullscreen", Boolean()),
    }, nil, {d="Set the window to fullscreen, or windowed mode."}),

    Function("is_fullscreen", nil, {
        Ret("val", Boolean()),
    }, {d="Check if the window is set to fullscreen."}),

    Function("set_window_title", {
        Arg("title", String()),
    }, nil, {d="Set the window's title."}),

    Function("set_window_vsync", {
        Arg("vsync", Boolean()),
    }, nil, {d="Set the window vsync flag to the given value."}),

    Function("is_window_vsync", nil , {
        Ret("val", Boolean()),
    }, {d="Check if the window vsync flag is set."}),

    Function("set_window_icon_file", {
        Arg("icon_path", String()),
    }, nil, {d="Set the window icon."}),

    Function("set_window_margins", {
        Arg("left", Integer()),
        Arg("right", Integer()),
        Arg("top", Integer()),
        Arg("bottom", Integer()),
    }, nil, {d="Set the window margins. Margins are ignored and no drawing can be made there.."}),

    Function("set_window_paddings", {
        Arg("left", Integer()),
        Arg("right", Integer()),
        Arg("top", Integer()),
        Arg("bottom", Integer()),
    }, nil, {d="Set the window paddings. Paddings are can be drawn on."}),

    Function("is_key_down", {
        Arg("key", Type("KeyboardKey"), {nativetype="enumstring"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given key is down."}),

    Function("is_key_pressed", {
        Arg("key", Type("KeyboardKey"), {nativetype="enumstring"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given key is pressed."}),

    Function("is_key_released", {
        Arg("key", Type("KeyboardKey"), {nativetype="enumstring"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given key is released."}),

    Function("is_key_repeat", {
        Arg("key", Type("KeyboardKey"), {nativetype="enumstring"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given key is repeated."}),

    Function("is_mouse_down", {
        Arg("mouse_button", Type("MouseButton"), {nativetype="enumstring"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given mouse button is down."}),

    Function("is_mouse_pressed", {
        Arg("mouse_button", Type("MouseButton"), {nativetype="enumstring"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given mouse button is pressed."}),

    Function("is_mouse_released", {
        Arg("mouse_button", Type("MouseButton"), {nativetype="enumstring"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given mouse button is released."}),

    Function("get_mouse_x", nil, {
        Ret("val", Integer()),
    }, {d="Get the mouse x position."}),

    Function("get_mouse_y", nil, {
        Ret("val", Integer()),
    }, {d="Get the mouse y position."}),

    Function("get_gamepad_count", nil, {
        Ret("val", Integer()),
    }, {d="Get the number of gamepads."}),

    Function("get_gamepad_name", {
        Arg("index", Integer()),
    }, {
        Ret("val", String()),
    }, {d="Get the name of the gamepad at the given index."}),

    Function("is_gamepad_down", {
        Arg("index", Integer()),
        Arg("gamepad_button", Type("GamepadButton"), {nativetype="enumstring"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given button of the gamepad at the given index is down."}),

    Function("is_gamepad_pressed", {
        Arg("index", Integer()),
        Arg("gamepad_button", Type("GamepadButton"), {nativetype="enumstring"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given button of the gamepad at the given index is pressed."}),

    Function("is_gamepad_released", {
        Arg("index", Integer()),
        Arg("gamepad_button", Type("GamepadButton"), {nativetype="enumstring"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given button of the gamepad at the given index is released."}),

    Function("get_gamepad_axis", {
        Arg("index", Integer()),
        Arg("gamepad_axis", Type("GamepadAxis"), {nativetype="enumstring"}),
    }, {
        Ret("val", Number()),
    }, {d="Get the given axis of the gamepad at the given index."}),

    Function("set_mastervolume", {
        Arg("mastervolume", Number()),
    }, nil, {d="Set the master volume."}),

    Function("get_mastervolume", nil, {
        Ret("val", Number()),
    }, {d="Get the master volume."}),

    Function("load_music", {
        Arg("music_path", String()),
    },{
        Ret("val", Type("Music"), {nativetype="udata"}),
    }, {d="Load the music specified in the path.", ctor=true}),

    Function("play_music", {
        Arg("music", Type("Music"), {nativetype="udata"}),
    }, nil, {d="Play the music."}),

    Function("pause_music", {
        Arg("music", Type("Music"), {nativetype="udata"}),
    }, nil, {d="Pause the music."}),

    Function("resume_music", {
        Arg("music", Type("Music"), {nativetype="udata"}),
    }, nil, {d="Resume the music."}),

    Function("stop_music", {
        Arg("music", Type("Music"), {nativetype="udata"}),
    }, nil, {d="Stop the music."}),

    Function("is_music_playing", {
        Arg("music", Type("Music"), {nativetype="udata"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given music is playing."}),

    Function("get_music_length", {
        Arg("music", Type("Music"), {nativetype="udata"}),
    }, {
        Ret("val", Number()),
    }, {d="Get the length of the given music object in seconds."}),

    Function("get_music_length_played", {
        Arg("music", Type("Music"), {nativetype="udata"}),
    }, {
        Ret("val", Number()),
    }, {d="Get the already played length of the given music object in seconds."}),

    Function("seek_music", {
        Arg("music", Type("Music"), {nativetype="udata"}),
        Arg("secs", Number()),
    }, nil, {d="Move the music time played to the given value."}),

    Function("set_music_volume", {
        Arg("music", Type("Music"), {nativetype="udata"}),
        Arg("volume", Number()),
    }, nil, {d="Set the volume of the given music object."}),

    Function("set_music_pan", {
        Arg("music", Type("Music"), {nativetype="udata"}),
        Arg("pan", Number()),
    }, nil, {d="Set the pan of the given music object."}),

    Function("set_music_pitch", {
        Arg("music", Type("Music"), {nativetype="udata"}),
        Arg("pitch", Number()),
    }, nil, {d="Set the pitch of the given music object."}),

    Function("get_music_volume", {
        Arg("music", Type("Music"), {nativetype="udata"}),
    }, {
        Ret("val", Number()),
    }, {d="Get the volume of the given music object."}),

    Function("get_music_pan", {
        Arg("music", Type("Music"), {nativetype="udata"}),
    }, {
        Ret("val", Number()),
    }, {d="Get the pan of the given music object."}),

    Function("get_music_pitch", {
        Arg("music", Type("Music"), {nativetype="udata"}),
    }, {
        Ret("val", Number()),
    }, {d="Get the pitch of the given music object."}),

    Function("load_sound", {
        Arg("sound_path", String()),
    },{
        Ret("val", Type("Sound"), {nativetype="udata"}),
    }, {d="Load the sound specified in the path.", ctor=true}),

    Function("clone_sound", {
        Arg("orig", Type("Sound"), {nativetype="udata"}),
    },{
        Ret("val", Type("Sound"), {nativetype="udata"}),
    }, {d="Clone the sound specified in the path.", ctor=true}),

    Function("play_sound", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
    }, nil, {d="Play the sound."}),

    Function("pause_sound", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
    }, nil, {d="Pause the sound."}),

    Function("resume_sound", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
    }, nil, {d="Resume the sound."}),

    Function("stop_sound", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
    }, nil, {d="Stop the sound."}),

    Function("is_sound_playing", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
    }, {
        Ret("val", Boolean()),
    }, {d="Check if the given sound is playing."}),

    Function("set_sound_volume", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
        Arg("volume", Number()),
    }, nil, {d="Set the volume of the given sound object."}),

    Function("set_sound_pan", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
        Arg("pan", Number()),
    }, nil, {d="Set the pan of the given sound object."}),

    Function("set_sound_pitch", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
        Arg("pitch", Number()),
    }, nil, {d="Set the pitch of the given sound object."}),

    Function("get_sound_volume", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
    }, {
        Ret("val", Number()),
    }, {d="Get the volume of the given sound object."}),

    Function("get_sound_pan", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
    }, {
        Ret("val", Number()),
    }, {d="Get the pan of the given sound object."}),

    Function("get_sound_pitch", {
        Arg("sound", Type("Sound"), {nativetype="udata"}),
    }, {
        Ret("val", Number()),
    }, {d="Get the pitch of the given sound object."}),

    Function("load_textfile", {
        Arg("file_path", String()),
    },{
        Ret("val", String()),
    },{ d="Load the file in the path."}),

    Function("save_textfile", {
        Arg("file_path", String()),
        Arg("data", String()),
    }, nil, {d="Append the text to the file in the path. Override if the file exists. Create if it doesn't exist."}),

    Function("save_textfile_append", {
        Arg("file_path", String()),
        Arg("data", String()),
    }, nil, {d="Append the text to the file in the path. Append at the end if the file exists. Create if it doesn't exist."}),

    Function("push_matrix", nil, nil, {d="Push the transform matrix."}),

    Function("pop_matrix", nil, nil, {d="Pop the transform matrix."}),

    Function("reset_matrix", nil, nil, {d="Reset the transformation matrix (load identity matrix.)"}),

    Function("translate", {
        Arg("delta_x", Integer()),
        Arg("delta_y", Integer()),
    }, nil, {d="Apply translation (changes transform matrix.)"}),

    Function("rotate", {
        Arg("angle", Number()),
    }, nil, {d="Apply rotation (changes transform matrix.)"}),

    Function("rotate_at", {
        Arg("angle", Number()),
        Arg("x", Integer()),
        Arg("y", Integer()),
    }, nil, {d="Apply rotation at the given location (changes transform matrix.)"}),

    Function("scale", {
        Arg("scale_x", Number()),
        Arg("scale_y", Number()),
    }, nil, {d="Apply scaling (changes transform matrix.)"}),

    Function("scale_at", {
        Arg("scale_x", Integer()),
        Arg("scale_y", Integer()),
        Arg("x", Number()),
        Arg("y", Number()),
    }, nil, {d="Apply scaling at the given location (changes transform matrix.)"}),

    Function("set_default_blendmode", {
        Arg("blendmode", Type("BlendMode"), {nativetype="enumstring"}),
    }, nil, {d="Set the default blendmode."}),

    Function("set_blendmode", {
        Arg("blendmode", Type("BlendMode"), {nativetype="enumstring"}),
    }, nil, {d="Set the effective blendmode."}),

    Function("reset_blendmode", nil, nil, {d="Reset the blendmode value to its default value."}),

    Function("set_default_filtermode", {
        Arg("filtermode", Type("FilterMode"), {nativetype="enumstring"}),
    }, nil, {d="Set the default filtermode."}),

    Function("set_filtermode", {
        Arg("filtermode", Type("FilterMode"), {nativetype="enumstring"}),
    }, nil, {d="Set the effective filtermode."}),

    Function("reset_filtermode", nil, nil, {d="Reset the filtermode value to its default value."}),

    Function("new_shader", {
        Arg("shaderdef", Type("ShaderDef"), {nativetype="udata"}),
    },{
        Ret("val", Type("Shader"), {nativetype="udata"}),
    }, {d="Create a shader with given specification.", ctor=true, c_api_skip=true}),

    Function("set_shader", {
        Arg("shader", Type("Shader"), {nativetype="udata"}),
    }, nil, {d="Set the custom shader and use it for consequent calls."}),

    Function("reset_shader", nil, nil, {d="Reset the shader, back to framework defaults."}),

    Function("set_shader_uniform", {
        Arg("shader", Type("Shader"), {nativetype="udata"}),
        Arg("uniform_name", String()),
        Arg("uniform_value", Type("ShaderUniformValue"), {nativetype="union"}),
    }, nil, {d="Set the specified uniform."}),

    Function("reset_shader_uniform", {
        Arg("shader", Type("Shader"), {nativetype="udata"}),
        Arg("uniform_name", String()),
    }, nil, {d="Reset the specified uniform."}),

    Function("new_shaderbuilder", nil, {
        Ret("val", Type("ShaderBuilder"), {nativetype="udata"}),
    }, {d="Create a ShaderBuilder object.", ctor=true}),

    Function("shaderbuilder_uniform", {
        Arg("shaderbuilder", Type("ShaderBuilder"), {nativetype="udata"}),
        Arg("uniform_name", String()),
        Arg("uniform_type", Type("UniformType"), {nativetype="enumstring"}),
    }, nil, {d="Add uniform definition to the shaderbuilder"}),

    Function("shaderbuilder_vertex", {
        Arg("shaderbuilder", Type("ShaderBuilder"), {nativetype="udata"}),
        Arg("vertex_code", String()),
    }, nil, {d="Add vertex code to the shaderbuilder"}),

    Function("shaderbuilder_fragment", {
        Arg("shaderbuilder", Type("ShaderBuilder"), {nativetype="udata"}),
        Arg("fragment_code", String()),
    }, nil, {d="Add fragment to the shaderbuilder"}),

    Function("shaderbuilder_build", {
        Arg("shaderbuilder", Type("ShaderBuilder"), {nativetype="udata"}),
    }, {
        Ret("shader", Type("Shader"), {nativetype="udata"})
    }, {d="Add fragment to the shaderbuilder", ctor="true"}),

    Record("Image", {
        Field("width", Integer(), {map_read = "get_image_width"}),
        Field("height", Integer(), {map_read = "get_image_height"}),
        Field("is_canvas", Boolean(), {map_read = "is_image_canvas"}),
    }, {d="Image type"}),

    Record("Font", nil, {d="Font type."}),

    Record("Music", {
        Field("playing", Boolean(), {map_read = "is_music_playing"}),
        Field("length", Number(), {map_read = "get_music_length"}),
        Field("length_played", Number(), {map_read = "get_music_length_played"}),
        Field("pan", Number(), {map_read = "get_music_pan", map_write = "set_music_pan"}),
        Field("pitch", Number(), {map_read = "get_music_pitch", map_write = "set_music_pitch"}),
        Field("volume", Number(), {map_read = "get_music_volume", map_write = "set_music_volume"}),
        Method("play", nil, nil, {map_to="play_music"}),
        Method("pause", nil, nil, {map_to="pause_music"}),
        Method("resume", nil, nil, {map_to="resume _music"}),
        Method("stop", nil, nil, {map_to="stop_music"}),
        Method("seek", {Arg("secs", Number())}, nil, {map_to="seek_music"}),
    }, {d="Music type."}),

    Record("Sound", {
        Field("pan", Number(), {map_read = "get_sound_pan", map_write = "set_sound_pan"}),
        Field("pitch", Number(), {map_read = "get_sound_pitch", map_write = "set_sound_pitch"}),
        Field("volume", Number(), {map_read = "get_sound_volume", map_write = "set_sound_volume"}),
        Method("clone", {Arg("orig", Type("Sound"), {nativetype="udata"})}, {Ret("val", Type("Sound"), {nativetype="udata"})}, {map_to="clone_sound"}),
        Method("pause", nil, nil, {map_to="pause_sound"}),
        Method("play", nil, nil, {map_to="play_sound"}),
        Method("resume", nil, nil, {map_to="resume_sound"}),
        Method("stop", nil, nil, {map_to="stop_sound"}),
    }, {d="Sound type."}),

    OneOf("ShaderUniformValue", {
        Option(Float()),
        Option(List(Float(), {max_count=4})),
        Option(Type("Image"), {nativetype="udata"}),
    }),

    Record("Shader", {
        Method("set", {
            Arg("uniform_name", String()),
            Arg("uniform_value", Type("ShaderUniformValue"), {nativetype="union"}),
        }, nil, {map_to = "set_shader_uniform"}),
        Method("reset", {
            Arg("uniform_name", String()),
        }, nil, {map_to = "reset_shader_uniform"}),
    }, {d="Shader type"}),

    Record("ShaderDef", {
        Field("frag", String()),
        Field("vert", String()),
        Field("uniforms", Dict(String(), Type("UniformType"))),
    }, {d="Shader definition: uniforms declaration, vertex and fragment shader code.", c_api_skip=true}),

    Record("ShaderBuilder", {
        Method("uniform", {
            Arg("uniform_name", String()),
            Arg("uniform_type", Type("UniformType"), {nativetype="enumstring"}),
        }, nil, {map_to="shaderbuilder_uniform"}),
        Method("vertex", {
            Arg("vertex_code", String()),
        }, nil, {map_to="shaderbuilder_vertex"}),
        Method("fragment", {
            Arg("fragment_code", String()),
        }, nil, {map_to="shaderbuilder_fragment"}),
        Method("build", nil, {
            Ret("shader", Type("Shader"), {nativetype="udata"})
        }, {map_to="shaderbuilder_build"}),
    }, {d="ShaderBuilder type"}),

    Enum("UniformType", {
        '_invalid', 'float', 'vec2', 'vec3', 'vec4', 'int', 'ivec2',
        'ivec3', 'ivec4', 'mat4', 'sampler2D',
    }, {d="Acceptable uniformtype values."}),

    Enum("BlendMode", {
        'none' , 'blend' , 'add' , 'mod' , 'mul' ,
    }, {d="Acceptable blendmode values."}),

    Enum("FilterMode", {
        '_invalid', 'nearest', 'linear',
    }, {d="Acceptable filtermode values."}),

    Enum("GamepadAxis", {
        'left_x', 'left_y', 'right_x', 'right_y', 'left_trigger', 'right_trigger',
    }, {d="Acceptable gamepadaxis values."}),

    Enum("GamepadButton", {
        'pad_a', 'pad_b', 'pad_x', 'pad_y', 'left_bumper', 'right_bumper',
        'back', 'start', 'guide', 'left_thumb', 'right_thumb', 'dpad_up',
        'dpad_right', 'dpad_down', 'dpad_left',
    }, {d="Acceptable gamepadbutton values."}),

    Enum("MouseButton", {
        'mb1', 'mb2', 'mb3', 'mb4', 'mb5', 'mb6',
        'mb7', 'mb8',
    }, {d="Acceptable mousebutton values."}),

    Enum("KeyboardKey", {
        'space', "'", ',', '-', '.', '/',
        '0', '1', '2', '3', '4', '5',
        '6', '7', '8', '9', ';', '=',
        'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l',
        'm', 'n', 'o', 'p', 'q', 'r',
        's', 't', 'u', 'v', 'w', 'x',
        'y', 'z', '[', '\\', ']', '`',
        'world_1', 'world_2', 'escape', 'enter', 'tab', 'backspace',
        'insert', 'delete', 'right', 'left', 'down', 'up',
        'page_up', 'page_down', 'home', 'end', 'caps_lock', 'scroll_lock',
        'num_lock', 'print_screen', 'pause', 'f1', 'f2', 'f3',
        'f4', 'f5', 'f6', 'f7', 'f8', 'f9',
        'f10', 'f11', 'f12', 'f13', 'f14', 'f15',
        'f16', 'f17', 'f18', 'f19', 'f20', 'f21',
        'f22', 'f23', 'f24', 'f25', 'kp_0', 'kp_1',
        'kp_2', 'kp_3', 'kp_4', 'kp_5', 'kp_6', 'kp_7',
        'kp_8', 'kp_9', 'kp_decimal', 'kp_divide', 'kp_multiply', 'kp_subtract',
        'kp_add', 'kp_enter', 'kp_equal', 'left_shift', 'left_control', 'left_alt',
        'left_super', 'right_shift', 'right_control', 'right_alt', 'right_super', 'menu',
    }, {d="Acceptable keyboardkey values."}),

})