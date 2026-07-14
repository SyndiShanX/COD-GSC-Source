/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\audio.gsc
**************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace audio;

function init_audio() {
  level.player clearallsoundsubmixes(0.05);

  if(isDefined(level.audio) && isDefined(level.audio.initialized)) {
    return;
  }

  init_audio_struct();
  level.audio.initialized = 1;
  setdvarifuninitialized(@ "debug_audio", "\xfe");
  setdvarifuninitialized(@ "debug_headroom", "Bf");
  setdvarifuninitialized(@ "music_enable", "\x87");
  setsaveddvar(@ "hash_687f6fe472201df1", 1);
  setsaveddvar(@ "hash_4e5b353bf84974a9", 1);
  setdvarifuninitialized(@ "hash_f133094f3b5288b6", 1);

  if(getprojectname() == "\x99\x0f\xab") {
    setsaveddvar(@ "hash_8136ae00f7d4f22f", 0);
  }

  level.player function_9d18ffbd46ffc44d();
  init_timescale();
  thread level_fadein();

  level.player thread function_4d25ffd1f5c7f135();
  level.player thread function_d81aa0c70895d420();

  utility_sp::post_load_precache(&function_7e6a18c316b06f9e);
}

function rex_emitter_test() {
  wait 2;
  uppressed = 0;

  while(true) {
    if(level.player buttonPressed(",\xac\xc2\xa4g\xe6\xf4")) {
      radiusdamage(level.player.origin, 1500, 150, 10, undefined, "\xa2rl\xdaDn\x17b\xd9I\xc9=N");
      wait 2;
    }

    wait 0.1;
  }
}

function init_audio_struct() {
  if(!isDefined(level.audio)) {
    level.audio = spawnStruct();
  }
}

function is_deathsdoor_audio_enabled() {
  if(!isDefined(level.audio.deathsdoor_enabled)) {
    return 1;
  }

  return level.audio.deathsdoor_enabled;
}

function restore_after_deathsdoor(fadetime) {
  if(is_deathsdoor_audio_enabled() || isDefined(level.audio.in_deathsdoor)) {
    level.audio.in_deathsdoor = undefined;
    level.player clearpriorityclienttriggeraudiozone("\x1b\x84:m\xb0\x8137N9");
    level.player function_10ff9b1be763739f();

    if(isDefined(level.deathsdoor_sfx)) {
      wait fadetime;

      if(isDefined(level.deathsdoor_sfx)) {
        level.deathsdoor_sfx playSound("t\xc7\xf2\xecnmY\xae\x94\xc0\xf1_\xd1\x98\xd1", "\xdc\xf6\xba\xdcFF\xdb\xe6e");
        level.deathsdoor_sfx waittill("\xdc\xf6\xba\xdcFF\xdb\xe6e");
      }

      if(isDefined(level.deathsdoor_sfx)) {
        level.deathsdoor_sfx delete();
      }
    }
  }
}

function set_deathsdoor() {
  level.audio.in_deathsdoor = 1;

  if(is_deathsdoor_audio_enabled()) {
    if(isDefined(level.deathsdooroverride)) {
      level.player setpriorityclienttriggeraudiozonepartial(level.deathsdooroverride, "\x1b\x84:m\xb0\x8137N9", "\a&\x99\xdb\xed\xb3");
      level.player function_c7cd0252a2ba2d42();
    } else {
      level.player setpriorityclienttriggeraudiozonepartial("\x1b\x84:m\xb0\x8137N9", "\x1b\x84:m\xb0\x8137N9", "\a&\x99\xdb\xed\xb3");
      level.player function_c7cd0252a2ba2d42();
    }

    if(!isDefined(level.deathsdoor_sfx)) {
      level.deathsdoor_sfx = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", level.player.origin);
      wait 0.05;
    }

    thread playerbreathingpainsound();
    level.deathsdoor_sfx playSound("N\x8c\x03\xc4\x95\x96^\xce=\xf9|!3\x84");
  }
}

function playerbreathingpainsound() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("k\xb3Yz.\xe8\xd6\xc3\xe0{\xb3\x88\xe9\xe4r\x9a1");
  self endon("\r+a\xb1\x95#");
  self endon("\x11\x93\x85\b\xbf\x9d\xc0|\xdaZw6\xaaf\xf0\x04\x1fA");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  if(getprojectname() == "\x99\x0f\xab") {
    wait 0.5;

    while(true) {
      level.player playlocalsound("vYD\xed\xc8'N\xe1\xf9\xf5$N\xc6\xee`$\xed\x95\xb7\x8bQR\x8a");
      wait 1.7;
    }
  }
}

function stop_deaths_door_audio() {
  if(isDefined(level.deathsdoor_sfx)) {
    level.deathsdoor_sfx scalevolume(0, 2);
    wait 2;

    if(isDefined(level.deathsdoor_sfx)) {
      level.deathsdoor_sfx stopsounds();
    }

    wait 0.05;

    if(isDefined(level.deathsdoor_sfx)) {
      level.deathsdoor_sfx delete();
    }
  }
}

function level_fadein() {
  if(!isDefined(level.audio.level_fade_time)) {
    level.audio.level_fade_time = 1;
  }

  wait 0.05;
  levelsoundfade(1, level.audio.level_fade_time);
}

function set_audio_level_fade_time(time) {
  init_audio_struct();
  level.audio.level_fade_time = time;
}

function audio_bink_transition_ambient(binktime, ambient_out, fadeout, ambient_in, fadein, musicstate, musicstatetime) {
  if(!isDefined(binktime)) {
    assertmsg("<dev string:x24>");
    return;
  }

  if(!isDefined(fadeout)) {
    fadeout = 2;
  }

  if(!isDefined(fadein)) {
    fadein = 2;
  }

  if(!isDefined(musicstatetime)) {
    musicstatetime = 2;
  }

  if(isDefined(musicstate)) {
    thread bink_transition_music(binktime, musicstate, musicstatetime);
  }

  almostfadein = fadein + 0.05;
  binkskipped = 1;

  if(isDefined(ambient_out)) {
    level.player setclienttriggeraudiozone(ambient_out);
  }

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  level.player setclienttriggeraudiozone("\n\x03\xd1H\xa2\xfb\x9a\xd6\xb01^\xd6Gy\x8d3\xcf#\xc9\x97\x0e\x993\x84^", fadeout);

  while(1 && iscinematicplaying()) {
    time = cinematicgettimeinmsec() / 1000;
    var_c2dba94deca04876 = binktime - time;

    if(var_c2dba94deca04876 <= almostfadein) {
      binkskipped = 0;
      break;
    }

    wait 0.05;
  }

  if(binkskipped == 0) {
    if(isDefined(ambient_in)) {
      level.player setclienttriggeraudiozone(ambient_in, fadein);
      wait 2;
      level.player clearclienttriggeraudiozone(2);
    } else {
      level.player clearclienttriggeraudiozone(fadein);
    }

    level.player clearsoundsubmix("r\xd1a\xed\xf7\x83s##2\xdf\ao'Gck\xd2e");
    return;
  }

  level.player clearclienttriggeraudiozone();
}

function bink_transition_music(binktime, musicstate, musicstatetime) {
  binkskipped = 1;
  almostfadein = musicstatetime + 0.05;

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(1 && iscinematicplaying()) {
    time = cinematicgettimeinmsec() / 1000;
    var_c2dba94deca04876 = binktime - time;

    if(var_c2dba94deca04876 <= almostfadein) {
      binkskipped = 0;
      break;
    }

    wait 0.05;
  }

  if(binkskipped == 0) {
    setmusicstate(musicstate);
  }
}

function audio_bink_fadeout_ambient(ambient_out, fadeout) {
  if(!isDefined(fadeout)) {
    fadeout = 2;
  }

  if(isDefined(ambient_out)) {
    level.player setclienttriggeraudiozone(ambient_out);
  }

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  level.player setclienttriggeraudiozone("\n\x03\xd1H\xa2\xfb\x9a\xd6\xb01^\xd6Gy\x8d3\xcf#\xc9\x97\x0e\x993\x84^", fadeout);
}

function audio_bink_fadein_ambient(binktime, ambient_in, fadein, musicstate, musicstatetime) {
  if(!isDefined(binktime)) {
    assertmsg("<dev string:x24>");
    return;
  }

  if(!isDefined(fadein)) {
    fadein = 2;
  }

  almostfadein = fadein + 0.05;

  if(!isDefined(musicstatetime)) {
    musicstatetime = 2;
  }

  if(isDefined(musicstate)) {
    thread bink_transition_music(binktime, musicstate, musicstatetime);
  }

  binkskipped = 1;

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(1 && iscinematicplaying()) {
    time = cinematicgettimeinmsec() / 1000;
    var_c2dba94deca04876 = binktime - time;

    if(var_c2dba94deca04876 <= almostfadein) {
      binkskipped = 0;
      break;
    }

    wait 0.05;
  }

  if(binkskipped == 0) {
    if(isDefined(ambient_in)) {
      level.player setclienttriggeraudiozone(ambient_in, fadein);
      wait 2;
      level.player clearclienttriggeraudiozone(2);
    } else {
      level.player clearclienttriggeraudiozone(fadein);
    }

    return;
  }

  level.player clearclienttriggeraudiozone();
}

function init_timescale() {
  level.audio.timescale = spawnStruct();
  level.audio.timescale.current = "";
  set_timescale("\x91\xca\xcc\v\xab\xd8:");
  soundsettimescalefactor("\xbe\xc3$na\xab\xd2#", 0);
  soundsettimescalefactor("KE\x10\x90>\xe98\xef\xaet", 0);
  soundsettimescalefactor("\xe8\x1aU\x83o=\x94\xa9/\xd8\xf8\v\x8e\xa0\x13", 0);
  soundsettimescalefactor("\xfb\xa9\xe3\xf2yW\xdb\xcd\xe9#\xdfq~\xe2zSo", 0);
  soundsettimescalefactor("9\xa3f\xa7\xe3\x15\xd0\xfa\xe2\xcb\xea3z\x1c", 0);
  soundsettimescalefactor("\xc7\\\xe9\xbf[\x10\xaf}\x14\xf0\xa3\x93P", 0);
  soundsettimescalefactor("\x95\xc8\xdc\xf6K~\x80\xb2\xab\xcd\xee\xc6v", 0);
  soundsettimescalefactor("`\xf8\x9d\x04\x10\x1f\xe7\xee\x12o\x90[@", 0);
  soundsettimescalefactor("\xc3\xbc\x1e\xf7\f\xf9\x04\xee\xa9{]\xb6\xad\xfc\xf7", 0);
  soundsettimescalefactor("n\x8dn\xd7\xb13V\xeb\xba\xcdr\xac\xcd}#d", 0);
  soundsettimescalefactor("~\xe6\xb1\x8c\x1d@\x1bR/W\n\x1cq", 0);
  soundsettimescalefactor("\xef\x87 \xc7\x85\xe3\xec\xd3b.rP\x87\xf2\xb6", 0);
  soundsettimescalefactor("\x8fFe2\bT\xa0}\xc4\xdf\xb7u\xff\xf7\x91\xe5", 0);
  soundsettimescalefactor("]\xd9 A\xa0w\xd2\xe0\xd8\x18\x8aYcO2\xe5", 0);
  soundsettimescalefactor("\x91v\x16\bV\x1b\xc2'I\x19\xd3\a#\xc5\xceQ|\x16\xb8\x96", 0);
  soundsettimescalefactor("u\x10\x8a\x057,\xd8\xfd4\ve\xcf)\xffU\x89", 0);
  soundsettimescalefactor("\x17\xa3\"\xdf'\x87\x8b\xf0FR6%\xfb\x01\xadL\xb9\xd7\xfd\xbe", 0);
  soundsettimescalefactor("%\t8q\x88\xc0<\xff\xaf\xafS\xa9\xc2B8\\\xab\xfd\"\xf1&\xfdf", 0);
  soundsettimescalefactor("jR\xe6\x83\x03{\xb3|\xd2\x94\n\xab\xd8\\\xb9\x9e\xd7\x1dv\xc9^\xbf$", 0);
  soundsettimescalefactor("\xcdl\xdc\xd73\x0f\xeb\x9b\x0ee\xc6\xd2X\xb1\xeb\xd579en_89{8}\x99\xc8", 0);
  soundsettimescalefactor("n\x8d\xe6}\x99\x1e\xd7\xea\xdc'e\xe6\xd7\xcc\x19\xd76-\xad", 0);
  soundsettimescalefactor("\xa8\xfam\x8e\xfdr7D\xa9\xe5oY\x82\xf0\xca(\xd4\xba\xad", 0);
  soundsettimescalefactor("~\xe6\xb1\x8c\x1d@\x1bR/W\n\x1cq", 0);
  soundsettimescalefactor("c\xdf1\x89r\xe8Y+\xd5\xceg2\x89", 0);
}

function set_slowmo_dialogue_start() {
  soundsettimescalefactor("e\xb8\xf8\xda\xd9^\xdaP\xb0\\\x93\xf7", 0);
  soundsettimescalefactor("T!q@\x82\xc0|\xab\xed\xd0\xf4;\x9d\xf8\x7f4", 0);
  soundsettimescalefactor("y\xf9w\xe8m?\xc0\xea\xc9u\x1a\xa4%\xdb\xea\x9f!\x8d", 0);
  soundsettimescalefactor("\xfc\xaf\x10\xb5x\xe21\x17a{1\xb7", 0);
  soundsettimescalefactor("\xa7\xab\x19[K\x15\xdc\xe5k\xc8;\\\x1a\xf0", 0);
  soundsettimescalefactor("\x80\xe93\xc0F\"a\x0f\xed\"W\xeb\xb4\xfb\x86\x8d\x87'\xd3\xe6", 0);
  soundsettimescalefactor("sh\xf0\x172*\fK#0\\b\f\xb8\x02\n\xd4\x17\xdc", 0);
  soundsettimescalefactor("\x0frzK\xab\xb5\xd1F\x92\x155\x06\xec\x82t\xd7l", 0);
  soundsettimescalefactor(";\xbdZ6\x95\xf5bc\x86a\xd1\x8eY\xc9_&\xebf\x19", 0);
}

function set_slowmo_dialogue_end() {
  soundsettimescalefactor("e\xb8\xf8\xda\xd9^\xdaP\xb0\\\x93\xf7", 1);
  soundsettimescalefactor("T!q@\x82\xc0|\xab\xed\xd0\xf4;\x9d\xf8\x7f4", 1);
  soundsettimescalefactor("y\xf9w\xe8m?\xc0\xea\xc9u\x1a\xa4%\xdb\xea\x9f!\x8d", 1);
  soundsettimescalefactor("\xfc\xaf\x10\xb5x\xe21\x17a{1\xb7", 1);
  soundsettimescalefactor("\xa7\xab\x19[K\x15\xdc\xe5k\xc8;\\\x1a\xf0", 1);
  soundsettimescalefactor("\x80\xe93\xc0F\"a\x0f\xed\"W\xeb\xb4\xfb\x86\x8d\x87'\xd3\xe6", 1);
  soundsettimescalefactor("sh\xf0\x172*\fK#0\\b\f\xb8\x02\n\xd4\x17\xdc", 1);
  soundsettimescalefactor("\x0frzK\xab\xb5\xd1F\x92\x155\x06\xec\x82t\xd7l", 1);
  soundsettimescalefactor(";\xbdZ6\x95\xf5bc\x86a\xd1\x8eY\xc9_&\xebf\x19", 1);
}

function set_slowmo_sniper_breath_start() {
  if(isfunction(level.var_d64be07e00a9dbda)) {
    assert(isPlayer(level.player), "<dev string:x6c>");
    level.player thread[[level.var_d64be07e00a9dbda]]();
    return;
  }

  soundsettimescalefactor("e\xb8\xf8\xda\xd9^\xdaP\xb0\\\x93\xf7", 0.05);
  soundsettimescalefactor("T!q@\x82\xc0|\xab\xed\xd0\xf4;\x9d\xf8\x7f4", 0.05);
  soundsettimescalefactor("y\xf9w\xe8m?\xc0\xea\xc9u\x1a\xa4%\xdb\xea\x9f!\x8d", 0.05);
  soundsettimescalefactor("\xfc\xaf\x10\xb5x\xe21\x17a{1\xb7", 0.05);
  soundsettimescalefactor("\xa7\xab\x19[K\x15\xdc\xe5k\xc8;\\\x1a\xf0", 0.05);
  soundsettimescalefactor("\x80\xe93\xc0F\"a\x0f\xed\"W\xeb\xb4\xfb\x86\x8d\x87'\xd3\xe6", 0.05);
  soundsettimescalefactor("sh\xf0\x172*\fK#0\\b\f\xb8\x02\n\xd4\x17\xdc", 0.05);
  soundsettimescalefactor("\x0frzK\xab\xb5\xd1F\x92\x155\x06\xec\x82t\xd7l", 0.05);
  soundsettimescalefactor(";\xbdZ6\x95\xf5bc\x86a\xd1\x8eY\xc9_&\xebf\x19", 0.05);
  soundsettimescalefactor("\xbf\x88\xb5\xca-d\x13\xf7\x04<", 0.2);
  soundsettimescalefactor("\xdb\x86_\x02=\x1a5\xc7\x8b\x80\xc2\x05Fa\xf1\x8d\xee", 0.05);
  soundsettimescalefactor("\xf1\x16\x8e\xf8\xf3/\x14\x810\xc5\xe00\xf4", 0.05);
  soundsettimescalefactor("\xeb\x9d\x83\xb3u\xcf\x03\xcaj\xe3\xc9\x99\x1d\xe6", 0.05);
  soundsettimescalefactor("\xd8g\xac\xda\x98\xa1\xb8wa\xc0#\x0f\x9b", 0.05);
  soundsettimescalefactor("X\xe7\xbcj\xee\xbaC\xe2W\x1fX2\xec\x8e", 0.05);
  soundsettimescalefactor("\xda\xf3\"E\xfa\xe2\x19\x93A\xed\\\x0f\f\xfa\xb9", 0.05);
  soundsettimescalefactor("l\x1au\x03(\xfc\n0\xa0Q\xe1\xfe\x87", 0.05);
  soundsettimescalefactor("\xb0\x8a\xe1\x8d\xe8FZ\xb6c{KI(\x02\xea\xa2\x0e", 0.05);
  soundsettimescalefactor("\xb1b\x010n\"\xe2'\xfa\"|\xcb", 0.05);
  soundsettimescalefactor("\xac\xf0\x1cl\xed\xfad\xa5n\x1d\xbe\xcc\xc8", 0.05);
  soundsettimescalefactor("\xb1\xd3\xe2<\xbc\x94\xba\x8c\xab\xb6\x9b\x1aL\xaeg\xab8L", 0.05);
  soundsettimescalefactor("x\xab\x1b\xf2\xc7\x98Fr\xfd|\x89\xbc+\xff\xa7\x9c5\xd7", 0.05);
  soundsettimescalefactor("\x93\x8b\xa2\xf1\x8b\xa7\xac\x13\xa2\x14\x01\xc3\xa7&\x89\xb9ky", 0.05);
  soundsettimescalefactor("\xc0\\\x1a\x19\xb7\xa7U\x89\xd3\xbe\xfbU\xc9\r-6\xd5l", 0.05);
  soundsettimescalefactor("\x1ax/\x8e+\xf9^,\x9bL\xb0\xa4\f\xcb\x9a4\xe3\xd21o|\xe1x\xa8", 0.05);
  soundsettimescalefactor("w\xca\v8}\x1c\xd8N\xaf\x99\xb4\x93\xca\xfa\xc6f\x95\xd7#\x19", 0.05);
}

function set_slowmo_sniper_breath_end() {
  if(isfunction(level.var_b65cc1ff436ac977)) {
    assert(isPlayer(level.player), "<dev string:xa0>");
    level.player thread[[level.var_b65cc1ff436ac977]]();
    return;
  }

  set_slowmo_dialogue_end();
  soundsettimescalefactor("\xbf\x88\xb5\xca-d\x13\xf7\x04<", 1);
  soundsettimescalefactor("\xdb\x86_\x02=\x1a5\xc7\x8b\x80\xc2\x05Fa\xf1\x8d\xee", 1);
  soundsettimescalefactor("\xf1\x16\x8e\xf8\xf3/\x14\x810\xc5\xe00\xf4", 1);
  soundsettimescalefactor("\xeb\x9d\x83\xb3u\xcf\x03\xcaj\xe3\xc9\x99\x1d\xe6", 1);
  soundsettimescalefactor("\xd8g\xac\xda\x98\xa1\xb8wa\xc0#\x0f\x9b", 1);
  soundsettimescalefactor("X\xe7\xbcj\xee\xbaC\xe2W\x1fX2\xec\x8e", 1);
  soundsettimescalefactor("\xda\xf3\"E\xfa\xe2\x19\x93A\xed\\\x0f\f\xfa\xb9", 1);
  soundsettimescalefactor("l\x1au\x03(\xfc\n0\xa0Q\xe1\xfe\x87", 1);
  soundsettimescalefactor("\xb0\x8a\xe1\x8d\xe8FZ\xb6c{KI(\x02\xea\xa2\x0e", 1);
  soundsettimescalefactor("\xb1b\x010n\"\xe2'\xfa\"|\xcb", 1);
  soundsettimescalefactor("\xac\xf0\x1cl\xed\xfad\xa5n\x1d\xbe\xcc\xc8", 1);
  soundsettimescalefactor("\xb1\xd3\xe2<\xbc\x94\xba\x8c\xab\xb6\x9b\x1aL\xaeg\xab8L", 1);
  soundsettimescalefactor("x\xab\x1b\xf2\xc7\x98Fr\xfd|\x89\xbc+\xff\xa7\x9c5\xd7", 1);
  soundsettimescalefactor("\x93\x8b\xa2\xf1\x8b\xa7\xac\x13\xa2\x14\x01\xc3\xa7&\x89\xb9ky", 1);
  soundsettimescalefactor("\xc0\\\x1a\x19\xb7\xa7U\x89\xd3\xbe\xfbU\xc9\r-6\xd5l", 1);
  soundsettimescalefactor("\x1ax/\x8e+\xf9^,\x9bL\xb0\xa4\f\xcb\x9a4\xe3\xd21o|\xe1x\xa8", 1);
  soundsettimescalefactor("w\xca\v8}\x1c\xd8N\xaf\x99\xb4\x93\xca\xfa\xc6f\x95\xd7#\x19", 1);
}

function function_7e6a18c316b06f9e() {
  if(isDefined(level.audio.fnsubmix)) {
    [[level.audio.fnsubmix]]();
    return;
  }

  if(isDefined(level.gamemodebundle)) {
    if(isDefined(level.gamemodebundle.var_2053c45f5d852b30)) {
      level.player setsoundsubmix(level.gamemodebundle.var_2053c45f5d852b30);
    }
  }
}

function function_2ba529d7fed07a73(func) {
  init_audio_struct();
  level.audio.fnsubmix = func;
}

function audio_helmet_transition_helmet_on_visor_down_w_lma(var_280e32776f030804, lma_speed, filter_setting) {
  if(!isDefined(var_280e32776f030804)) {
    var_280e32776f030804 = 2.5;
  }

  if(!isDefined(lma_speed)) {
    lma_speed = "+0a<s,";
  }

  if(!isDefined(filter_setting)) {
    filter_setting = "\xf1r\x0f\xd5\v\x12\xe6Aa";
  }

  level.player playSound("\x87A\xb5\xcb\xb2I+.\xf0\x0f\x04\x9e\xc6\x98^vd\xfe\"\xc3Jg\xa3\xae\x190 ");

  if(var_280e32776f030804 != 0) {
    wait var_280e32776f030804;

    if(lma_speed == "+0a<s,") {
      level.player utility::delaycall(0.1, &playsound, "1\x1eR\xe9nY\xe2rT\xf3\xe4\xdbk\xb2\x165\xafz\xa5\xbb\x92\xd0E|{\x9e[");
    } else {
      level.player utility::delaycall(0.1, &playsound, "\xc4\x1d9\xc0m\xeb\xc3\xdb\xf8\x93V\xba\tw\xf2*2\x9cj\xed\xf5U4\xdb\x82G");
    }

    if(filter_setting == "\xf1r\x0f\xd5\v\x12\xe6Aa") {
      level.player utility::delaycall(0.45, &clearclienttriggeraudiozone, 0.2);
      return;
    }

    level.player utility::delaycall(0.45, &setclienttriggeraudiozone, filter_setting, 0.2);
  }
}

function audio_helmet_transition_helmet_on_visor_up_no_lma() {}

function audio_helmet_transition_visor_down_w_lma(var_280e32776f030804, lma_speed, filter_setting) {
  if(!isDefined(var_280e32776f030804)) {
    var_280e32776f030804 = 2.5;
  }

  if(!isDefined(lma_speed)) {
    lma_speed = "+0a<s,";
  }

  if(!isDefined(filter_setting)) {
    filter_setting = "\xf1r\x0f\xd5\v\x12\xe6Aa";
  }

  level.player playSound("'\xaf\xd9\xfe\a\xd4\xe6F\xa7O{i\xcc\xb2\xd2\xfa\x8f& 5m\xc1?\x16!\xfc\xd0\xdb\xfcE\x13\x89i\x0f\x83?");
  wait var_280e32776f030804;

  if(lma_speed == "+0a<s,") {
    level.player utility::delaycall(0.1, &playsound, "1\x1eR\xe9nY\xe2rT\xf3\xe4\xdbk\xb2\x165\xafz\xa5\xbb\x92\xd0E|{\x9e[");
  } else {
    level.player utility::delaycall(0.1, &playsound, "\xc4\x1d9\xc0m\xeb\xc3\xdb\xf8\x93V\xba\tw\xf2*2\x9cj\xed\xf5U4\xdb\x82G");
  }

  if(filter_setting == "\xf1r\x0f\xd5\v\x12\xe6Aa") {
    level.player utility::delaycall(0.45, &clearclienttriggeraudiozone, 0.2);
    return;
  }

  level.player utility::delaycall(0.45, &setclienttriggeraudiozone, filter_setting, 0.2);
}

function audio_helmet_transition_visor_up() {
  level.player playSound("\x0e\xc2e\xbcX\xeb{\x94\xa4\xe4\xe2+\x04&\xfe\xa1\x9c\x1f\x95\xc1&\x90\xf8\xf9\buM\xe0\x04\xa7\xe5*\x83");
}

function audio_helmet_transition_helmet_off_release_scripted_filter() {
  level.player playSound("\x83\x1b\x9c\xbe\xa1e\xd8k\x95\xa3\xf5of\x99\xeb6\xe4");
  level.player playSound("Z8\xd5\xfe\x8c\xedi\xbc\xbd\xefCi\xf2\xc6\xb4\xdd\x18\xbf\x9c\xf1.");
  level.player clearclienttriggeraudiozone(0.25);
}

function audio_helmet_transition_helmet_off_no_filter_change() {
  level.player playSound("\x83\x1b\x9c\xbe\xa1e\xd8k\x95\xa3\xf5of\x99\xeb6\xe4");
}

function set_timescale(name) {
  if(level.audio.timescale.current == name) {
    return;
  }

  level.audio.timescale.current = name;

  msg = "<dev string:xd2>" + name;
  debug_println(msg, 2);

  soundsettimescalefactorfromtable(name);
}

function debug_println(msg, dvar_num) {
  if(!isDefined(dvar_num)) {
    dvar_num = 1;
  }

  if(debug_enabled() < 1) {
    return;
  }

  println("<dev string:x104>" + msg);
}

function debug_enabled() {
  dvar = getdvarint(@ "debug_audio");

  if(dvar > 0) {
    return dvar;
  }

  return 0;
}

function function_4d25ffd1f5c7f135() {
  for(;;) {
    if(getDvar(@ "scr_setclothtype") != "<dev string:x10e>") {
      thread gui_setclothtype();
    }

    if(getDvar(@ "scr_setgeartype") != "<dev string:x10e>") {
      thread function_614f051978081db5();
    }

    waitframe();
  }
}

function gui_setclothtype() {
  clothtype = getDvar(@ "scr_setclothtype");
  setdevdvar(@ "scr_setclothtype", "<dev string:x10e>");
  player = level.player;

  if(isDefined(clothtype) && clothtype != "<dev string:x10e>") {
    if(isDefined(player.clothtype) && player.clothtype == clothtype) {}

    if(!isDefined(player.clothtype)) {
      player.clothtype = "<dev string:x10e>";
    }

    if(isDefined(player.clothtype) && player.clothtype != clothtype) {
      player.clothtype = clothtype;
      player setclothtype(getxhash(clothtype));
    }
  }
}

function function_614f051978081db5() {
  geartype = getDvar(@ "scr_setgeartype");
  setdevdvar(@ "scr_setgeartype", "<dev string:x10e>");
  player = level.player;

  if(isDefined(geartype) && geartype != "<dev string:x10e>") {
    if(isDefined(player.geartype) && player.geartype == geartype) {}

    if(!isDefined(player.geartype)) {
      player.geartype = "<dev string:x10e>";
    }

    if(isDefined(player.geartype) && player.geartype != geartype) {
      player.geartype = geartype;
      player setgeartype(getxhash(geartype));
    }
  }
}

function function_d81aa0c70895d420() {
  i = 0;

  for(;;) {
    if(getdvarint(@ "hash_f75720f29df3df7") != 0 && i == 0) {
      level.player setsoundsubmix("<dev string:x112>", 1, 1);
      setglobalsoundcontext("<dev string:x130>", "<dev string:x13e>");
      level.player setclienttriggeraudiozone("<dev string:x13e>", 1);
      i = 1;
    } else if(getdvarint(@ "hash_f75720f29df3df7") == 0 && i == 1) {
      level.player clearsoundsubmix("<dev string:x112>", 2.2);
      setglobalsoundcontext("<dev string:x130>", "<dev string:x10e>");
      level.player clearclienttriggeraudiozone(1);
      i = 0;
    }

    waitframe();
  }
}

function function_9d18ffbd46ffc44d() {
  self.var_2c283b611066f22a = "\xcc\a\xf5\xb0}\x8d\x01\xde\xb9=\x02(w\xf6";

  if(isDefined(level.var_8a15105551274412)) {
    self.var_2c283b611066f22a = level.var_8a15105551274412;
  }
}

function function_c7cd0252a2ba2d42(fadetime, scale) {
  if(isDefined(level.gamemodebundle.var_2c283b611066f22a)) {
    str_submix = level.gamemodebundle.var_2c283b611066f22a;
    n_fadetime = level.gamemodebundle.var_362b0596d04cfe3b ?? -1;
    n_scale = level.gamemodebundle.var_130ddd9f3e7dadd6 ?? 1;
    self setsoundsubmix(str_submix, n_fadetime, n_scale);
  }
}

function function_10ff9b1be763739f() {
  if(isDefined(level.gamemodebundle.var_2c283b611066f22a)) {
    str_submix = level.gamemodebundle.var_2c283b611066f22a;
    n_fadetime = level.gamemodebundle.var_48fafe5bc63c82ca ?? -1;
    self clearsoundsubmix(str_submix, n_fadetime);
  }
}

function function_2142f256f9d0f5f7(new_submix, fade_out_time = 0, fade_in_time = 0) {
  if(isDefined(level.var_8f16a22fbecaf24b)) {
    if(new_submix == level.var_8f16a22fbecaf24b) {
      return;
    }

    level.player clearsoundsubmix(level.var_8f16a22fbecaf24b, fade_out_time);
  }

  if(isDefined(new_submix)) {
    level.player setsoundsubmix(new_submix, fade_in_time);
  }

  level.var_8f16a22fbecaf24b = new_submix;
}

function function_96ea94b22a553b4e(transient_submix, fade_out_time = 0, fade_in_time = 0, var_3cbdd9578ea2866e = 1) {
  if(!isDefined(transient_submix)) {
    return;
  }

  if(!isDefined(level.var_ea72c4c6e24edc7a)) {
    level.var_ea72c4c6e24edc7a = "";
  }

  if(isDefined(level.var_8f16a22fbecaf24b) && var_3cbdd9578ea2866e == 1) {
    level.player clearsoundsubmix(level.var_8f16a22fbecaf24b, fade_out_time);
  }

  if(level.var_ea72c4c6e24edc7a != transient_submix) {
    level.var_ea72c4c6e24edc7a = transient_submix;
    level.player setsoundsubmix(level.var_ea72c4c6e24edc7a, fade_in_time);
  }
}

function function_7e9948e11254f084(fade_out_time = 0, fade_in_time = 0, var_4f1018f620f5cd45 = 1) {
  if(isDefined(level.var_ea72c4c6e24edc7a)) {
    level.player clearsoundsubmix(level.var_ea72c4c6e24edc7a, fade_out_time);
  }

  if(isDefined(level.var_8f16a22fbecaf24b) && var_4f1018f620f5cd45 == 1) {
    level.player setsoundsubmix(level.var_8f16a22fbecaf24b, fade_in_time);
  }
}