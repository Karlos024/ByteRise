if (!tutorial_permite(object_index)) exit;
if (visible) {
    image_xscale = 1.5;
    image_yscale = 1.9;
    audio_play_sound(snd_Screen_change, 1, false);
    
    if (instance_exists(obj_ctld_Tutorial)) {
        if (obj_ctld_Tutorial.atual < obj_ctld_Tutorial.maximo) {
            obj_ctld_Tutorial.atual += 1;
        }
    }
}