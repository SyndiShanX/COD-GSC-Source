/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_audio_mix_manager.gsc
***********************************************/

mm_init() {
  if(!isdefined(level._audio))
    level._audio = spawnstruct();

  if(!isdefined(level._audio.mix))
    level._audio.mix = spawnstruct();

  level._audio.mix.curr_preset = undefined;
  level._audio.mix.zonemix = [];
}

mm_start_preset(var_0, var_1) {
  if(!isdefined(level._audio.mix.curr_preset) || var_0 != level._audio.mix.curr_preset) {
    clearallsubmixes(0.0);

    if(isdefined(var_1))
      addsoundsubmix(var_0, var_1);
    else
      addsoundsubmix(var_0);

    level._audio.mix.curr_preset = var_0;
  }
}

mm_start_zone_preset(var_0) {
  foreach(var_2 in level._audio.mix.zonemix) {
    if(var_0 != var_2) {
      makesoundsubmixunsticky(var_2);
      clearsoundsubmix(var_2, 1.0);
      level._audio.mix.zonemix[var_2] = undefined;
    }
  }

  mmx_start_zone_preset(var_0);
}

mm_clear_zone_mix(var_0, var_1) {
  var_2 = 1.0;

  if(isdefined(var_1))
    var_2 = var_1;

  if(!isdefined(var_0)) {
    foreach(var_0 in level._audio.mix.zonemix) {
      makesoundsubmixunsticky(var_0);
      clearsoundsubmix(var_0, var_2);
      level._audio.mix.zonemix[var_0] = undefined;
    }
  } else if(isdefined(level._audio.mix.zonemix[var_0])) {
    makesoundsubmixunsticky(var_0);
    clearsoundsubmix(var_0, var_2);
    level._audio.mix.zonemix[var_0] = undefined;
  }
}

mm_blend_zone_mix(var_0, var_1, var_2, var_3) {
  if(isdefined(var_0) && var_0 != "none") {
    if(var_1 == 0)
      mm_clear_zone_mix(var_0, 0.0);
    else {
      mmx_start_zone_preset(var_0);
      blendsoundsubmix(var_0, var_1, 0.0);
    }
  }

  if(isdefined(var_2) && var_2 != "none") {
    if(var_3 == 0)
      mm_clear_zone_mix(var_2, 0.0);
    else {
      mmx_start_zone_preset(var_2);
      blendsoundsubmix(var_2, var_3, 0.0);
    }
  }
}

mm_clear_submixes(var_0) {
  clearallsubmixes(var_0);
  level._audio.mix.curr_preset = undefined;
}

mm_make_submix_sticky(var_0) {
  makesoundsubmixsticky(var_0);
}

mm_make_submix_unsticky(var_0) {
  makesoundsubmixunsticky(var_0);
}

mm_add_submix(var_0, var_1) {
  if(isdefined(var_1))
    addsoundsubmix(var_0, var_1);
  else
    addsoundsubmix(var_0);
}

mm_scale_submix(var_0, var_1, var_2) {
  var_3 = 0.0;

  if(isdefined(var_2))
    var_3 = var_2;

  addsoundsubmix(var_0, var_3, var_1);
}

mm_blend_submix(var_0, var_1, var_2) {
  var_1 = clamp(var_1, 0, 1);
  var_3 = 0.0;

  if(isdefined(var_2))
    var_3 = var_2;

  blendsoundsubmix(var_0, var_1, var_3);
}

mm_clear_submix(var_0, var_1) {
  if(isdefined(var_1))
    clearsoundsubmix(var_0, var_1);
  else
    clearsoundsubmix(var_0);

  if(isdefined(level._audio.mix.curr_preset) && level._audio.mix.curr_preset == var_0)
    level._audio.mix.curr_preset = undefined;
}

mm_add_dynamic_volmod_submix(var_0, var_1, var_2) {
  var_3 = 0.0;

  if(isdefined(var_2))
    var_3 = var_2;

  addsoundsubmix(var_0, var_3, 1.0, var_1);
}

mm_mute_volmods(var_0, var_1) {
  var_2 = [];

  if(isstring(var_0)) {
    var_2[var_2.size] = var_0;
    var_2[var_2.size] = 0.0;
  } else {
    foreach(var_4 in var_0) {
      var_2[var_2.size] = var_4;
      var_2[var_2.size] = 0.0;
    }
  }

  mm_add_dynamic_volmod_submix("mm_mute", var_2, var_1);
}

mm_clear_volmod_mute_mix(var_0) {
  if(isdefined(var_0))
    clearsoundsubmix("mm_mute", var_0);
  else
    clearsoundsubmix("mm_mute");
}

mm_solo_volmods(var_0, var_1) {
  var_2 = [];
  var_2[var_2.size] = "set_all";
  var_2[var_2.size] = 0.0;

  if(isstring(var_0)) {
    var_2[var_2.size] = var_0;
    var_2[var_2.size] = 1.0;
  } else {
    foreach(var_4 in var_0) {
      var_2[var_2.size] = var_4;
      var_2[var_2.size] = 1.0;
    }
  }

  mm_add_dynamic_volmod_submix("mm_solo", var_2, var_1);
}

mm_clear_solo_volmods(var_0) {
  if(isdefined(var_0))
    clearsoundsubmix("mm_solo", var_0);
  else
    clearsoundsubmix("mm_solo");
}

mmx_start_zone_preset(var_0) {
  if(!isdefined(level._audio.mix.zonemix[var_0])) {
    addsoundsubmix(var_0);
    makesoundsubmixsticky(var_0);
    level._audio.mix.zonemix[var_0] = var_0;
  }
}