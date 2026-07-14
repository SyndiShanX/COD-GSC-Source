/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\trigger.gsc
**************************************/

#using script_3798db193e76a866;
#using scripts\anim\battlechatter;
#using scripts\common\ai;
#using scripts\common\fx;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_code;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\art;
#using scripts\sp\audio;
#using scripts\sp\autosave;
#using scripts\sp\colors;
#using scripts\sp\compass;
#using scripts\sp\fakeactor;
#using scripts\sp\lights;
#using scripts\sp\mgturret;
#using scripts\sp\player_death;
#using scripts\sp\slide_volume;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\utility;
#using scripts\sp\vehicle;
#using scripts\stealth\player;
#namespace trigger;

function get_load_trigger_classes() {
  trigger_classes = [];
  trigger_classes["[\xbf\x13\xf0O\xed\xee0\xbf\xaf\x8f\xaf1Cx\x9f\x91\xb8\x90r\xa9N.\xfd\xf9\xad.\xb5"] = &trigger_nobloodpool;
  trigger_classes["t\xe4K\xec;\x95r\xeb\xad\xeac\xd1-\a\xb1+\xbe\x996\x85\xec\xd7\xdcV\x8e"] = &trigger_flag_set;
  trigger_classes["\xcf\xab\xaa_\x8b\x15\x108Q\x83\xde\xfb\xb0z\xc2\xdc\x8f3\xda\xe1+U "] = &trigger_flag_set;
  trigger_classes["\xa3\xe4-\xb3\xd9e'\xfa\xb5\xae\x8dt\xd2\x1cl\x95\xf5f\xc6\v;}\xb16\xb2,'"] = &trigger_flag_clear;
  trigger_classes["\x8c\xe9\xc7.{\xfb*\xac\xcb\xf7m~\xac\x9c\xe0\x10
    trigger_classes["\x1d\xe4-\xb3\x9dV9\xeb\xad\xd5\xb1\xa3i\a\xb1\xb2\xfan\xban\xfa\xf6\x99\xcc"] = &trigger_sun_off; trigger_classes["\xe8'i\xce\x9d\xb2\x93_\xda\xab\xc6\xe8\xd2\x1ccV_su\xe6\xaf\xb7\xdc"] = &trigger_sun_on; trigger_classes["z6$X\xa7\xf8\t\xefK\x80\xfe\x80\xf9\x9e\xae^,2z8"] = &trigger_flag_set; trigger_classes["\xcc\xd5gMD\x8dv\xc0\x16p\x97\xf8\xc4\x84$yUEDG\xc7\x1c"] = &trigger_flag_clear; trigger_classes["\x1d\xe4i\xd9\xd9V\x93}\xb6uc\xa3\xa5\a\x8d+\xaf\x99l\x16g\xf5\x9b\xca\xd1_\x1d{\xae\xb1\x1aing"] = &trigger_flag_set_touching; trigger_classes["\xe6\xf1`,\xfeP\xdf_d\":\xd4#\b\x82_+\x9a-\xa3\xfd\xdd\x16ct\xf39\xa7"] = &trigger_lookat; trigger_classes["\xa3N\x96\xb3\xec+r\xeb\xb6]c\x1d\xa5\x83\xb1\xac\xf53lX\xd9_\xd8\xed\xbdkK\xcdg"] = &trigger_looking; trigger_classes["y\xf9N\x98\x7f\x7f\xccP\xf0\xe5(sR\xb2.M\\x)\x9fQ(\x18 \xb7"] = &trigger_no_prone; trigger_classes["f\x0e\x8e\xd7m\x18\xac\xf1\x97x\x1e\x9cz\xb2\x98\xcb\xb0/2\xc0G \xfa\x14Z \xd3q\xce\x17\xe3rsX\xa1"] = &trigger_no_crouch_or_prone; trigger_classes["\x8e\x93\xa5\xb3g\xb2\xc9}\xb6\xba\x8d\x1di\x0el\xca\xf5\xb1ok\x0ea\xe6\xe6"] = &trigger_multiple_compass; trigger_classes["s\xb6\xbb/3\xfaO\xe64\xbd\tU\xaaf\x1d\x11k\x9e\xc7\x93%\xc3\xaa3\xcf\xe0"] = &trigger_multiple_fx_volume; trigger_classes["\bPd\xe7\x7f\x90c\x01\x9c\xb6q\x1ew\xe2\xdd\"\xa0\xbd8\xe2'D\x12\xcb"] = &trigger_multiple_kleenex; trigger_classes["HIE;{\xada\xd5\xc1\xf4\x1a8\x9b\xd6\xbb+\xdd\xbb\xbb\xf3\xe4\\Q\xe3\x14\xb8\x83\xfb\xda\xef\xd7'"] = &lights::sun_shadow_trigger;

    if(!starts::is_no_game_start()) {
      trigger_classes["\x10\xbf\xd4\xce\xf5a\x03\xc7\xb4\x1dt}\xc0\xf8\xf3\bg\xfctT\xc9i?\xf3e"] = &autosave::trigger_autosave;
      trigger_classes["z6$X\xa7\xf8\t\xef{\xb0z\xe5\x18\x90\xc6Z,\xa2r8\xbe\xf0Q\xad[\xa1\xf0n\xb8r\xdax"] = &autosave::function_b3826144c7b99297;
      trigger_classes["\x1b\t\x1dge\xde\x05\xb1\x92uOp\x85\x9e\xa0\x1a\xb9\x11\x8e\x05H\x89"] = &spawner::trigger_spawner;
      trigger_classes[",\xe3\xad\x86TH\x8b\x06\x9e\xc9\xee;\xc7\x90\x1e^\x95\"\xecmVt\xee\xf1}Z\xe1NI\xd76\xbf\x9b\x16H:"] = &spawner::trigger_spawner_reinforcement;
      trigger_classes["\x9c\xbb+\x8a\xdcC\xeeh#\x9aZ9\x19\xf0\x1a\xf80;l\xd8}i\xfeU\x93\xb6X"] = &spawner::trigger_zone_spawn;
    }

    trigger_classes["\x96i\x83\x92\x9d\xdf\xc9\x05\xa2n\x9b\x84\x18gFZD\xd2\xdc|v\xb3\xbd\xc3\x13O\xc9\xf6s\xdfp"] = &trigger_stealth_shadow; trigger_classes["\xd73\xcap\x03\xd4\x8d&\xce\xdd\xb9\xa3\x04L]\xb2\x10\xa7\x19\x03\xfc\xfe"] = &slide_volume::trigger_slide; trigger_classes["\x81^A|H\x80\x1d\xac\xd4\xe0Q\xc83\v\xb6\xe0\xe4A\xd0\x17\xbf%~\x974\x01\xa5\xf3?"] = &trigger_multiple_depthoffield; trigger_classes["\xed)\xcf\xb5\xd9\xd1\x05\xdb;\x9e\x9cK9jc!\xd1U\x8e\xff\x85t\"\xa8\xcc\xbd\x8dy\xb5\xd4\xbev6|\\"] = &trigger_multiple_tessellationcutoff; trigger_classes["\x9fBE\xe7\xb7^v]\x92PT\x01:\x86\x9f\xd8\x88Cz\xe4\x83\xc0\xca\xb5\xba[s\xb63."] = &trigger_damage_player_flag_set; trigger_classes["\x9as\x02\xd4\xa1\xf1\xb9\xd6\xb4\xbe\xa1\x1c\x8c\x9dm2^\xf7w\xcbU$_\xbfN;\x17\x80"] = &trigger_glass_break; trigger_classes["j\xd4\xe3\x12\xec\xf9\x97^\x96\xbf\xd4j\vn\x86[\xb1\xa0\xcb\xf7\x14\xaaa\x8aml"] = &trigger_glass_break; trigger_classes["\x10\xbf\xd4\xce\xf5a\x03\xc7\xb4\x1dt}\xc0\xf8\xf3\bg\xf2h\x86\x99t\xbd\xc7y\xcc\xb2\xc7a6!g\x8c"] = &trigger_friendly_respawn; trigger_classes["`\xe3\x9c\a!G\xaapQ\x85K\x8b\xc3\x02\xea\x10\xb1:\xf2S9\x13\xa4\xe1SW\xef\xb3\x87ja \xf8\xc3\n\xfb\xb3;"] = &trigger_friendly_stop_respawn; trigger_classes["N\x8f\xc9d_M)g\x04ig\xcce\x8d\x90[\xf8G\xacsKc\xe9\xe5"] = &trigger_physics; trigger_classes["\x89\x9f\xf0q&wA~\xd5\xcc\xbcB\x87\xc0\x04\xba3\xe6\x02\x98\"%|\x9fe\xe5l\xbf\xdb\xa4\x88\xde\xe6"] = &trigger_multiple_fx_watersheeting; trigger_classes["yF\xbc\x99\xf1\xc7\xd3p\x10\xa9,w\xf9x\xadsD?\xd8\xcb:\x85olG\xe5/\x91\xe0x\xe4"] = &fakeactor::trigger_fakeactor_move; trigger_classes["BW\xd4\a\x95\"9G*\xa1\x03\xd02v\xb2\xd18\xe7\xe5t\xb0`i\xda\x0e\x14\x90\xff/r\xb5\xb6\\y\t\x9b\x8aG\x81"] = &fakeactor::trigger_fakeactor_node_disable; trigger_classes["\x98O=\r\x89\xdb\x0f\x97D\x15D\xc2\x82J\x1e%\xf3\xc4\x16\xed\xb9\xe8\xb3\bY\xd8z\xf9n\x9b\x81o\x013^'"] = &fakeactor::trigger_fakeactor_node_enable; trigger_classes["\xc5t\xcc\xaaA\xeeT\x7f\xf13\x96\xf0\xf94\x1e ;f4\x01\xe7\x9ba2\x14\xab3\x19\\\x0f\xd2^A\x0e6\xfb\x9a\xf0\xef'\xbc\xe3 \x9a"] = &fakeactor::trigger_fakeactor_node_disablegroup; trigger_classes["\x16lz;\fkpOtu\xb43\x11\xb4X\x99X%\xbe\v\x13\x16W)\xd1\x8b\x05\xc6\xa1\xb4\x95B]\xcd\xdc\xd9\xc8> J\xdf\xe3\xf2"] = &fakeactor::trigger_fakeactor_node_enablegroup; trigger_classes["\x13\xaao\xcb\x7fR\xae\xe9\x17`?\xcc\x14\xf5\xf2\x0e[\x8c\xef\xf3\xf2$\xc1\x86\xaa\xe1\x86\x92\xef\xd9\xb4\x886\x1a\x1bY\xe2\x93 \x12\xab\xf7\x02"] = &fakeactor::trigger_fakeactor_node_passthrough; trigger_classes["3Dt\xe4dnc\x91f0/\xe3\x95\x93xFF\x9d+\xeaR\xb2\x93\x14\xb0\xf9@dL\xc3\x95\xad\x19{l0"] = &fakeactor::trigger_fakeactor_node_lock;

    trigger_classes["<dev string:x24>"] = &trigger_createart_transient;

    trigger_classes["\x946\x8f\x06#\xc9\x97\xf7\x1f\x03`\x8f\xe81R\xa2\xef#\xea\x1c\x95\x8d\xe6\x8da\r"] = &trigger_multiple_transient; trigger_classes["\xee4\xe4Q1Zk\r4&s\xad\rX\xbb+\xc5\xd4\x9d\x82\xdc"] = &trigger_fire; trigger_classes["\x87\xeb\xee\x9e\xf6\xa0;\tN'\xc7s\x9c\x0e\x170^\xb3u"] = &trigger_fire; trigger_classes["\xc4\x19\xda\x04\xc8\xd2;@Y\xf5\xf2Xt\xf99LS1\xc8E\xf3\xb5"] = &trigger_multiple_fx; trigger_classes["\xf6+\xcb\x10\x8bS\x18\xa2<\xbb\x81\x01A\xf2\xdc\x1ec\xa5\xe4\xb0\xd9\x95Z"] = &trigger_multiple_fx; trigger_classes["\xe6y\xbf\x03^\xafF\xeeH_?\xf6x\xe6^<%\xef)dY\xb91>[\xea"] = &trigger_flag_set_touching; trigger_classes["\b\xbdg\x05v/\x01\xc1\x9c\xbd\xd5\xccB\x05\xfe\x02G\xe7\xcc\xf0\xcf\xf5\xb1"] = &trigger_unlock; trigger_classes["\x9ea_\x80\\\xc9\x9f\x1ep,X\xa02\xee\xe6L\xbed~\xb8\"l\x17\xa4\xba\x9aBo}\xafyQL\xdc"] = &lights::function_97b058da0ce47fcd;
    return trigger_classes;
  }

  function trigger_multiple_fx_watersheeting(trigger) {
    duration = 3;

    if(isDefined(trigger.script_duration)) {
      duration = trigger.script_duration;
    }

    while(true) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);

      if(isPlayer(other)) {
        other setwatersheeting(1, duration);
        wait duration * 0.2;
      }
    }
  }

  function get_load_trigger_funcs() {
    trigger_funcs = [];
    trigger_funcs["\xf8$R\x9b\xc7\x1d0\x86\x9dY\bY)\xe7\x0e\x89\xac"] = &spawner::friendly_mgturret;

    if(!starts::is_no_game_start()) {
      trigger_funcs["\"*MU-(\x84\xb1\xfcQ\xb4x\xd0\xf5"] = &spawner::camper_trigger_think;
      trigger_funcs["\xde\xc7#\xba\xf9\xa10Ik\xb0\xbb\xc5Y"] = &spawner::flood_trigger_think;
      trigger_funcs["\x98\xd5^S(Q\xae-\xafI\x9f`L]\x18"] = &spawner::trigger_spawner;
      trigger_funcs["\xaf\xbfoW\xb0\x11\xee\x9fP\x7f\x84\x91'\xe5\xf5\xe3"] = &autosave::trigger_autosave;
      trigger_funcs["\xb8\x19hYw\xeco<\xd1\xc2\xf2\xb9\xb1\xb0\xae\a@\x1c"] = &trigger_spawngroup;
      trigger_funcs["\xbd)\t\x8f\x90\xb5,\x82;\xfc#\xb8\xd3u\xb9\xc3o\x88]\x972\xca\xd3\v\n\x8b\x87\x84"] = &trigger_vehicle_spline_spawn;
      trigger_funcs["\xc0\x14\x87\xa6\x7f6v\x8c\x1e\xb3\n9\xa6\x83\xd5r\xb0\xb07\xb2N"] = &spawner::trigger_spawner;
      trigger_funcs["~\x9b\xbap8C\xbe~\x10\xbd\x0e\xc8"] = &spawner::random_spawn;
      trigger_funcs[" \xcc\xfak%a\xf8\xd8\x1a\t"] = &spawner::trigger_zone_spawn;
    }

    trigger_funcs["/i\x84'j\xd2\x14o\x97\xf4hv"] = &autosave::autosave_now_trigger;
    trigger_funcs["5\xf9\xa5\x94\xa5<|\xef4\xbf1sn\xa1\x8b\xc6R\vN\x18F\xb2\xb1}\xe8"] = &autosave::trigger_autosave_tactical;
    trigger_funcs["\x96\x16\xa7gX\xb4\xd1\x98G\x8dt}7SI\xa8`4\xfd\xfaA\xf8\xd2q"] = &autosave::trigger_autosave_stealth;
    trigger_funcs["\xa4#~Bp.`(m\x13\x16Q@\xf7"] = &trigger_unlock;
    trigger_funcs["\xf7n\x93%\x1d\f\xdagt@D8\x95\xd7"] = &trigger_lookat;
    trigger_funcs["\xf7FIp\xa5zI\xff\xach\xdb\xe8\vj\x86"] = &trigger_looking;
    trigger_funcs["k\xa0\x01\xd7\xc2\xb7\xd2\x81h\xef\xe0\x9dp\xa9"] = &trigger_cansee;
    trigger_funcs["\x96\x1d\xf7^\x1f\xd3UO"] = &trigger_flag_set;
    trigger_funcs["\x98\xe5\x8b\xf9\xb4T*\xd3\xa6\x89\xb3_8C6"] = &trigger_flag_set_player;
    trigger_funcs["=\x0flU\xfe\x96L\xcf\xb7\n"] = &trigger_flag_clear;
    trigger_funcs["\x1b\\A\xe7W\xdfJ\xd3\xd3a"] = &trigger_flag_clear;
    trigger_funcs["RJ\x10\"bI\xf5\x11\xeb\x807'a\xa2u-\x90.\x8e\x82\xa2g0\x89"] = &trigger_friendly_respawn;
    trigger_funcs["\x93\x91\xf5\x14\xbeE\xf2\x93\xd0\xd2w\xb9q"] = &trigger_radio;
    trigger_funcs["z\xed-\xda\xea4K\xe4\xd1\xfe\x04\xb3\xad\x9e"] = &trigger_ignore;
    trigger_funcs["\xb2\xf9\xab\xd1\x90O\xd1k@}H\v\xb4\xb0\x01u"] = &trigger_pacifist;
    trigger_funcs["\x97-c/c\xf8\xc7\xdck\x1a\xfcn<Q"] = &trigger_turns_off;
    trigger_funcs["\xfa\xdd\xc1\x90\xae\xac\xda\xc9\x0f\xa1\x06\xceu\xb5\xde\xf7X|\xd6E\x8e\x12\x81"] = &trigger_delete_on_touch;
    trigger_funcs["\xcd\xf8\x02\xf9\x1c\xbe\xd6F\xab+m"] = &trigger_turns_off;
    trigger_funcs[")\x8eZ~w\x9c\xc0\x9e\x88BT\xee\xfbUN"] = &spawner::outdoor_think;
    trigger_funcs["\x1d\xe4-\xb3\x9dV9\xeb-\xb9\x91{o'"] = &spawner::indoor_think;
    trigger_funcs["0n\xa3\xac\xfe\xf5\x1d\x81G\xa9\x13\x8c"] = &trigger_hint;
    trigger_funcs["zCh\x9d@ ~\xe2\x90\xf0QT0\x1a\xb5\x0f\xcf;z\x96\x8cmc\xb0\x05"] = &trigger_throw_grenade_at_player;
    trigger_funcs["\xf5>\xf9:\xe9\xbc4\xe5\xd8\x8d}\xa3\xaf\xd9X"] = &trigger_flag_on_cleared;
    trigger_funcs["\xb9{\xd7\xb1^\xa5\xdfT0\xfb&Y\tpzX\x99"] = &trigger_flag_set_touching;
    trigger_funcs["\x8cu\xaf\xec\xbd{\xfa&w\xd9|l\xff\xe2!\x05\xdc"] = &trigger_delete_link_chain;
    trigger_funcs["\xd8\x9b\xa2\xe4J\xc5I\b,\xb3%\xdc2"] = &slide_volume::trigger_slide;
    trigger_funcs["_\xf0\xa6\x13\xfd\x9d\xdc\x16dC\x8d\xae3Y\r\xcb"] = &trigger_dooropen;
    trigger_funcs["\x9cYs2NP\xc5\xf5\xf1\xde\xc2k\x7f"] = &trigger_outofbounds;
    trigger_funcs["U\xc0\xdfO\xc5\x1a6\xa6\x04\xc2\xe3\xc3J\"\x83\x88\"&"] = &trigger_no_crouch_or_prone;
    trigger_funcs[".\x87\xf9\xac\xad\xe7\xf1\x1d"] = &trigger_no_prone;
    return trigger_funcs;
  }

  function init_script_triggers() {
    colors::init_colors();
    audio::init_audio();
    utility::array_delete(getEntArray("\x120\xc5\xa7\xf0\x02\xd9\xd1p`Ld\xd7\x15\xce\x9dH>\x8d\xaclH\xc1H\xc8\x01Z\xe0", #classname));
    trigger_classes = get_load_trigger_classes();
    trigger_funcs = get_load_trigger_funcs();
    utility::registersharedfunc(#"oob", #"hash_4fb0dbfb79809bfd", &function_bd5c661e1bf090e);

    foreach(function in trigger_classes) {
      triggers = getEntArray(classname, #classname);
      utility::array_levelthread(triggers, function);
    }

    trigger_multiple = getEntArray("E\x03\xae\xad\x7f\xcc\xa9\x17\xda\xb0K\xa4s\xeb\xfb\xf7", #classname);
    trigger_radius = getEntArray("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", #classname);
    triggers = utility_sp::array_merge(trigger_multiple, trigger_radius);
    trigger_once = getEntArray("\xcd\xf8\x02\xf9\x1c\xbe\xd6F\xab\v=\x9a", #classname);
    triggers = utility_sp::array_merge(triggers, trigger_once);

    if(!starts::is_no_game_start()) {
      for(i = 0; i < triggers.size; i++) {
        if(triggers[i].spawnflags & 32) {
          thread spawner::trigger_spawner(triggers[i]);
        }
      }
    }

    code_classes = ["E\x03\xae\xad\x7f\xcc\xa9\x17\xda\xb0K\xa4s\xeb\xfb\xf7", "\xcd\xf8\x02\xf9\x1c\xbe\xd6F\xab\v=\x9a", "0\x85\x9f\xfa\xcb\x0f\xdb\xfct^(", "\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", "\xcd\xf8\x02\xf9\x1c\xbe\xd6F\xb1\x0f\x8c", "\xf7n\x93%\x1d\f\xdagt@D8\x95\xd7", ")\xa0Q\x9f\xee\xba\xddH\x84B\r=\xfb\b"];

    foreach(triggertype in code_classes) {
      triggers = getEntArray(triggertype, #code_classname);
      function_a279f497765139(triggers, trigger_funcs);
    }

    var_c82cfc5de6f77b8f = ["e\x8b\xed\xbc\xd8\xdb$\x97\x83\x90\x8e\x9a5\x06\x9c\xcdzP\xcd\xf5\xdfn\x83\x0f"];

    foreach(var_10ac326c019070fc in var_c82cfc5de6f77b8f) {
      var_e229beaf1fb4c6a3 = function_ac311f3d6717d47d(var_10ac326c019070fc, #code_classname);
      function_a279f497765139(var_e229beaf1fb4c6a3, trigger_funcs);
    }
  }

  function function_a279f497765139(triggers, trigger_funcs) {
    foreach(trigger in triggers) {
      if(isDefined(trigger.script_flag_true)) {
        level thread trigger_script_flag_true(trigger);
      }

      if(isDefined(trigger.script_flag_false)) {
        level thread trigger_script_flag_false(trigger);
      }

      if(isDefined(trigger.script_autosavename) || isDefined(trigger.script_autosave)) {
        level thread autosave::function_57c110a583f5ca9e(trigger);
      }

      if(isDefined(trigger.script_mgturretauto)) {
        level thread mgturret::mgturret_auto(trigger);
      }

      if(isDefined(trigger.script_killspawner)) {
        level thread spawner::kill_spawner(trigger);
      }

      if(isDefined(trigger.script_kill_vehicle_spawner)) {
        level thread vehicle_code::vehicle_triggerkillspawner(trigger);
      }

      if(isDefined(trigger.script_emptyspawner)) {
        level thread spawner::empty_spawner(trigger);
      }

      if(isDefined(trigger.script_prefab_exploder)) {
        trigger.script_exploder = trigger.script_prefab_exploder;
      }

      if(isDefined(trigger.script_exploder)) {
        level thread exploder_load(trigger);
      }

      if(isDefined(trigger.script_triggered_playerseek)) {
        level thread trigger_playerseek(trigger);
      }

      if(isDefined(trigger.script_bctrigger)) {
        level thread trigger_battlechatter(trigger);
      }

      if(isDefined(trigger.script_trigger_group)) {
        trigger thread trigger_group();
      }

      if(isDefined(trigger.script_random_killspawner)) {
        level thread spawner::random_killspawner(trigger);
      }

      if(isDefined(trigger.targetname)) {
        targetname = trigger.targetname;

        if(isDefined(trigger_funcs[targetname])) {
          level thread[[trigger_funcs[targetname]]](trigger);
        }
      }
    }
  }

  function trigger_createart_transient(trigger) {
    delete_trigger = 1;

    delete_trigger = 0;
    assert(isDefined(trigger.script_transient), "<dev string:x4c>" + trigger.origin + "<dev string:x6f>");

    if(!isDefined(level.var_93f3b61ccbe7f63d)) {
      level.var_93f3b61ccbe7f63d = [];
    }

    level.var_93f3b61ccbe7f63d[level.var_93f3b61ccbe7f63d.size] = trigger;
    level thread createart_transient_thread();

    if(delete_trigger) {
      trigger delete();
    }
  }

  function createart_transient_thread() {
    level notify("<dev string:x90>");
    level endon("<dev string:x90>");

    while(!is_transient_createart_enabled()) {
      wait 1;
    }

    current_trans = "<dev string:xae>";
    all_trans = [];

    foreach(trigger in level.var_93f3b61ccbe7f63d) {
      array = strtok(trigger.script_transient, "<dev string:xb2>");

      foreach(tran in array) {
        exists = 0;

        if(!arraycontains(all_trans, tran)) {
          all_trans[all_trans.size] = tran;
        }
      }
    }

    new_trans = current_trans;

    while(true) {
      wait 1;

      if(!is_transient_createart_enabled()) {
        continue;
      }

      foreach(trigger in level.var_93f3b61ccbe7f63d) {
        if(level.player istouching(trigger)) {
          new_trans = trigger.script_transient;
          break;
        }
      }

      if(current_trans != new_trans) {
        load_array = [];
        unload_array = [];
        var_c710f0f353a27caf = strtok(new_trans, "<dev string:xb2>");

        foreach(str in all_trans) {
          if(arraycontains(var_c710f0f353a27caf, str)) {
            load_array[load_array.size] = str;
            continue;
          }

          unload_array[unload_array.size] = str;
        }

        if(current_trans == "<dev string:xae>") {
          unloadalltransients();
        }

        if(unload_array.size > 0) {
          utility_sp::transient_unload_array(unload_array);
        }

        foreach(trans in load_array) {
          utility_sp::transient_load(trans);
        }

        current_trans = new_trans;
      }
    }
  }

  function is_transient_createart_enabled() {
    if(getDvar(@ "createfx") != "") {
      return true;
    }

    if(getdvarint(@ "scr_art_tweak") > 0) {
      return true;
    }

    if(isDefined(level.start_point) && level.start_point == "@w^' \xdaR") {
      return true;
    }

    return false;
  }

  function trigger_multiple_transient(trigger) {
    pass = 0;

    if(!isDefined(trigger.script_transient) && !isDefined(trigger.script_transient_unload) && !isDefined(trigger.script_transient_set) && !isDefined(trigger.script_transient_unload_set) && !isDefined(trigger.var_9330df80a028909b) && !isDefined(trigger.var_b78682f87fc0605a)) {
      assertmsg("<dev string:xb7>" + trigger.origin + "<dev string:xd9>");
    }

    loads = undefined;
    unloads = undefined;
    load_set = undefined;
    unload_set = 0;
    vis = undefined;
    invis = undefined;

    if(isDefined(trigger.script_transient)) {
      loads = strtok(trigger.script_transient, "\xda");
    }

    if(isDefined(trigger.script_transient_unload)) {
      unloads = strtok(trigger.script_transient_unload, "\xda");
    }

    if(isDefined(trigger.script_transient_set)) {
      load_set = trigger.script_transient_set;
    }

    if(isDefined(trigger.script_transient_unload_set)) {
      unload_set = 1;
    }

    if(isDefined(trigger.var_9330df80a028909b)) {
      vis = strtok(trigger.var_9330df80a028909b, "\xda");
    }

    if(isDefined(trigger.var_b78682f87fc0605a)) {
      invis = strtok(trigger.var_b78682f87fc0605a, "\xda");
    }

    flag_check = [];
    flag_check = utility::array_combine(loads, unloads);

    if(isDefined(trigger.script_transient_set)) {
      names = gettransientsinset(trigger.script_transient_set);
      flag_check = utility::array_combine(flag_check, names);
    }

    foreach(str in flag_check) {
      if(!utility::flag_exist(str + "y\xdc\xd6\xf3\x01\xab\xc9")) {
        utility::flag_init(str + "y\xdc\xd6\xf3\x01\xab\xc9");
      }
    }

    while(true) {
      trigger waittill("\x91`\xb1\xe7T\x97>");

      if(isDefined(vis)) {
        utility_sp::function_1ed713c8f3632197(vis);
      }

      if(isDefined(unloads)) {
        utility_sp::transient_unload_array(unloads);
      }

      if(isDefined(loads)) {
        utility_sp::transient_load_array(loads);
      }

      if(isDefined(invis)) {
        utility_sp::function_2fe3ca3a7904f6e6(invis);
      }

      if(isDefined(load_set)) {
        switchtransientset(load_set);
      }

      if(istrue(unload_set)) {
        switchtransientset("\r+x5");
      }
    }
  }

  function trigger_damage_player_flag_set(trigger) {
    flag = trigger utility_sp::get_trigger_flag();

    if(!isDefined(level.flag[flag])) {
      utility::flag_init(flag);
    }

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);

      if(!isalive(other)) {
        continue;
      }

      if(!isPlayer(other)) {
        continue;
      }

      trigger utility::script_delay();
      utility::flag_set(flag, other);
    }
  }

  function trigger_flag_clear(trigger) {
    flag = trigger utility_sp::get_trigger_flag();

    if(!isDefined(level.flag[flag])) {
      utility::flag_init(flag);
    }

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>");
      trigger utility::script_delay();
      utility::flag_clear(flag);
    }
  }

  function trigger_flag_on_cleared(trigger) {
    flag = trigger utility_sp::get_trigger_flag();

    if(!isDefined(level.flag[flag])) {
      utility::flag_init(flag);
    }

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>");
      wait 1;

      if(trigger found_toucher()) {
        continue;
      }

      break;
    }

    utility::flag_set(flag);
  }

  function found_toucher() {
    ai = getaiarray("\x9a\x1f\x83\x1bs=\x13\xf8");

    for(i = 0; i < ai.size; i++) {
      guy = ai[i];

      if(!isalive(guy)) {
        continue;
      }

      if(guy istouching(self)) {
        return true;
      }

      wait 0.1;
    }

    ai = getaiarray("\x9a\x1f\x83\x1bs=\x13\xf8");

    for(i = 0; i < ai.size; i++) {
      guy = ai[i];

      if(guy istouching(self)) {
        return true;
      }
    }

    return false;
  }

  function trigger_flag_set(trigger) {
    flag = trigger utility_sp::get_trigger_flag();

    if(!isDefined(level.flag[flag])) {
      utility::flag_init(flag);
    }

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);
      trigger utility::script_delay();
      utility::flag_set(flag, other);

      if(!isDefined(trigger)) {
        break;
      }
    }
  }

  function trigger_friendly_respawn(trigger) {
    trigger endon("\x1e\xfd\xd1\xa2\a");
    org = getEnt(trigger.target, #targetname);
    origin = undefined;

    if(isDefined(org)) {
      origin = org.origin;
      org delete();
    } else {
      org = utility::getStruct(trigger.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
      assert(isDefined(org), "<dev string:x185>");
      origin = org.origin;
    }

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>");
      level.respawn_spawner_org = origin;
      utility::flag_set("res\a\x85\xee7\xbe\xcc\xc9\xb4\xacn\x19\xb1-e\xb9");
      wait 0.5;
    }
  }

  function trigger_landingzone(trigger) {
    flag = trigger utility_sp::get_trigger_flag();

    if(!isDefined(level.flag[flag])) {
      utility::flag_init(flag);
    }

    if(!isDefined(level.landingzones_active)) {
      level.landingzones_active = [];
    }

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", player);

      if(isalive(player) && isDefined(trigger) && player istouching(trigger)) {
        level.landingzones_active = utility::array_add(level.landingzones_active, trigger);
      }

      while(isalive(player) && isDefined(trigger) && player istouching(trigger)) {
        if(!utility::flag(flag)) {
          thread trigger_landingzone_active(flag);
        }

        wait 0.25;
      }

      level.landingzones_active = arrayremove(level.landingzones_active, trigger);
    }
  }

  function trigger_landingzone_active(flag) {
    utility::flag_set(flag);

    for(;;) {
      level.landingzones_active = utility::array_removeundefined(level.landingzones_active);

      if(level.landingzones_active.size == 0) {
        break;
      }

      wait 0.25;
    }

    utility::flag_clear(flag);
  }

  function trigger_flag_set_touching(trigger) {
    flag = trigger utility_sp::get_trigger_flag();

    if(!isDefined(level.flag[flag])) {
      utility::flag_init(flag);
    }

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);
      trigger utility::script_delay();

      if(isalive(other) && isDefined(trigger) && other istouching(trigger)) {
        utility::flag_set(flag);
      }

      while(isalive(other) && isDefined(trigger) && other istouching(trigger)) {
        wait 0.25;
      }

      utility::flag_clear(flag);
    }
  }

  function trigger_friendly_stop_respawn(trigger) {
    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>");
      utility::flag_clear("res\a\x85\xee7\xbe\xcc\xc9\xb4\xacn\x19\xb1-e\xb9");
    }
  }

  function trigger_group() {
    thread trigger_group_remove();
    level endon("D\x82qA\x83(\\`\xecX4\xb9\x1e\xf8" + self.script_trigger_group);
    self waittill("\x91`\xb1\xe7T\x97>");
    level notify("D\x82qA\x83(\\`\xecX4\xb9\x1e\xf8" + self.script_trigger_group, self);
  }

  function trigger_group_remove() {
    level waittill("D\x82qA\x83(\\`\xecX4\xb9\x1e\xf8" + self.script_trigger_group, trigger);

    if(self != trigger) {
      self delete();
    }
  }

  function trigger_nobloodpool(trigger) {
    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);

      if(!isalive(other)) {
        continue;
      }

      other.skipbloodpool = 1;
      other thread set_wait_then_clear_skipbloodpool();
    }
  }

  function set_wait_then_clear_skipbloodpool() {
    self notify("\xca\x9fb2\xed\x7f\x9aF\xa4!U\a\xe6\xa1[{\xf9\xc5\x10_\xe3\x13oo\xb4(\xd7\xddWB\xafL\x18\xdb\xc3\xad");
    self endon("\xca\x9fb2\xed\x7f\x9aF\xa4!U\a\xe6\xa1[{\xf9\xc5\x10_\xe3\x13oo\xb4(\xd7\xddWB\xafL\x18\xdb\xc3\xad");
    self endon("\x1e\xfd\xd1\xa2\a");
    wait 2;
    self.skipbloodpool = undefined;
  }

  function trigger_physics(trigger) {
    assert(isDefined(trigger.target), "<dev string:x1c4>" + trigger.origin + "<dev string:x1db>");
    ents = [];
    structs = utility::getStructArray(trigger.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    orgs = getEntArray(trigger.target, #targetname);

    foreach(org in orgs) {
      struct = spawnStruct();
      struct.origin = org.origin;
      struct.script_parameters = org.script_parameters;
      struct.script_damage = org.script_damage;
      struct.radius = org.radius;
      structs[structs.size] = struct;
      org delete();
    }

    assert(structs.size, "<dev string:x1c4>" + trigger.origin + "<dev string:x1db>");
    trigger.org = structs[0].origin;
    trigger waittill("\x91`\xb1\xe7T\x97>");
    trigger utility::script_delay();

    foreach(struct in structs) {
      radius = struct.radius;
      vel = struct.script_parameters;
      damage = struct.script_damage;

      if(!isDefined(radius)) {
        radius = 350;
      }

      if(!isDefined(vel)) {
        vel = 0.25;
      }

      setDvar(@ "tempdvar", vel);
      vel = getdvarfloat(@ "tempdvar");

      if(isDefined(damage)) {
        radiusdamage(struct.origin, radius, damage, damage * 0.5);
      }

      physicsexplosionsphere(struct.origin, radius, radius * 0.5, vel);
    }
  }

  function trigger_playerseek(trig) {
    groupnum = trig.script_triggered_playerseek;
    trig waittill("\x91`\xb1\xe7T\x97>");
    ai = getaiarray();

    for(i = 0; i < ai.size; i++) {
      if(!isalive(ai[i])) {
        continue;
      }

      if(isDefined(ai[i].script_triggered_playerseek) && ai[i].script_triggered_playerseek == groupnum) {
        ai[i].goalradius = 800;
        ai[i] setgoalentity(level.player);
        level thread spawner::delayed_player_seek_think(ai[i]);
      }
    }
  }

  function trigger_script_flag_false(trigger) {
    tokens = utility::create_flags_and_return_tokens(trigger.script_flag_false);
    trigger add_tokens_to_trigger_flags(tokens);
    trigger utility::update_trigger_based_on_flags();
  }

  function trigger_script_flag_true(trigger) {
    tokens = utility::create_flags_and_return_tokens(trigger.script_flag_true);
    trigger add_tokens_to_trigger_flags(tokens);
    trigger utility::update_trigger_based_on_flags();
  }

  function add_tokens_to_trigger_flags(tokens) {
    for(i = 0; i < tokens.size; i++) {
      flag = tokens[i];

      if(!isDefined(level.trigger_flags[flag])) {
        level.trigger_flags[flag] = [];
      }

      level.trigger_flags[flag][level.trigger_flags[flag].size] = self;
    }
  }

  function trigger_spawngroup(trigger) {
    waittillframeend();
    assert(isDefined(trigger.script_spawngroup), "<dev string:x1fa>" + trigger.origin + "<dev string:x214>");
    spawngroup = trigger.script_spawngroup;

    if(!(isDefined(level.spawn_group) && isDefined(level.spawn_groups[spawngroup]))) {
      return;
    }

    trigger waittill("\x91`\xb1\xe7T\x97>");
    spawners = utility::random(level.spawn_groups[spawngroup]);

    foreach(spawner in spawners) {
      spawner utility_sp::spawn_ai();
    }
  }

  function trigger_sun_off(trigger) {
    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);

      if(getdvarint(@ "sm_sunenable") == 0) {
        continue;
      }

      setsaveddvar(@ "sm_sunenable", 0);
    }
  }

  function trigger_sun_on(trigger) {
    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);

      if(getdvarint(@ "sm_sunenable") == 1) {
        continue;
      }

      setsaveddvar(@ "sm_sunenable", 1);
    }
  }

  function trigger_vehicle_spline_spawn(trigger) {
    trigger waittill("\x91`\xb1\xe7T\x97>");
    spawners = getEntArray(trigger.target, #targetname);

    foreach(spawner in spawners) {
      spawner thread vehicle::spawn_vehicle_and_attach_to_spline_path(70);
      wait 0.05;
    }
  }

  function get_trigger_targs() {
    triggers = [];
    target_origin = undefined;

    if(isDefined(self.target)) {
      targets = getEntArray(self.target, #targetname);
      orgs = [];

      foreach(target in targets) {
        if(target.classname == "\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc" || target.classname == "\xff\xf2\xceW\x82\x17?c\x9b\xc1\xe6\x80\x140\xb9\xa1_\xc5") {
          orgs[orgs.size] = target;
        }

        if(issubstr(target.classname, "\x91`\xb1\xe7T\x97>")) {
          triggers[triggers.size] = target;
        }
      }

      targets = utility::getStructArray(self.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

      foreach(target in targets) {
        orgs[orgs.size] = target;
      }

      assert(orgs.size < 2, "<dev string:x231>" + self.origin + "<dev string:x240>");

      if(orgs.size == 1) {
        org = orgs[0];
        target_origin = org.origin;

        if(isDefined(org.code_classname)) {
          org delete();
        }
      }
    }

    if(isDefined(self.targetname)) {
      assert(isDefined(target_origin), self.targetname + "<dev string:x264>" + self.origin + "<dev string:x26c>");
    } else {
      assert(isDefined(target_origin), self.classname + "<dev string:x264>" + self.origin + "<dev string:x26c>");
    }

    array = [];
    array["\xc8!\x186\x83\x13}\xbc"] = triggers;
    array["N\x04\xf3\x841]\xf0\xe5\r\x9c?\xd6x"] = target_origin;
    return array;
  }

  function trigger_lookat(trigger) {
    trigger_lookat_think(trigger, 1);
  }

  function trigger_looking(trigger) {
    trigger_lookat_think(trigger, 0);
  }

  function trigger_lookat_think(trigger, endonflag) {
    success_dot = 0.78;

    if(isDefined(trigger.script_dot)) {
      success_dot = trigger.script_dot;
      assert(success_dot <= 1, "<dev string:x286>");
    }

    array = trigger get_trigger_targs();
    triggers = array["\xc8!\x186\x83\x13}\xbc"];
    target_origin = array["N\x04\xf3\x841]\xf0\xe5\r\x9c?\xd6x"];
    has_flag = isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy);
    flagname = undefined;

    if(has_flag) {
      flagname = trigger utility_sp::get_trigger_flag();

      if(!isDefined(level.flag[flagname])) {
        utility::flag_init(flagname);
      }
    } else if(!triggers.size) {
      assert(isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy), "<dev string:x2ae>" + trigger.origin + "<dev string:x2c4>");
    }

    if(endonflag && has_flag) {
      level endon(flagname);
    }

    trigger endon("\x1e\xfd\xd1\xa2\a");
    do_sighttrace = 1;

    if(isDefined(trigger.script_nosight)) {
      do_sighttrace = trigger.script_nosight;
    }

    duration = 0;

    if(isDefined(trigger.script_duration)) {
      duration = trigger.script_duration;
    }

    debounce = 0.05;

    if(do_sighttrace) {
      debounce = 0.5;
    }

    for(;;) {
      if(has_flag) {
        utility::flag_clear(flagname);
      }

      trigger waittill("\x91`\xb1\xe7T\x97>", other);
      assert(isPlayer(other), "<dev string:x32b>");
      touching_trigger = [];
      time_elapsed = 0;

      while(other istouching(trigger)) {
        player_eye = other getEye();

        if(do_sighttrace) {
          sighttracesuccess = 0;

          if(isDefined(level.var_bd64e4f8c2ca8f80)) {
            sighttracesuccess = trace::ray_trace_passed(player_eye, target_origin, level.player, level.var_bd64e4f8c2ca8f80);
          } else {
            sighttracesuccess = sighttracepassed(player_eye, target_origin, 0, undefined);
          }

          if(!sighttracesuccess) {
            time_elapsed = 0;

            if(has_flag) {
              utility::flag_clear(flagname);
            }

            wait debounce;
            continue;
          }
        }

        normal = vectorNormalize(target_origin - player_eye);
        player_angles = other getplayerangles();
        player_forward = anglesToForward(player_angles);
        dot = vectordot(player_forward, normal);

        if(dot >= success_dot) {
          time_elapsed += debounce;

          if(time_elapsed >= duration) {
            utility::array_thread(triggers, &utility::send_notify, "\x91`\xb1\xe7T\x97>");

            if(has_flag) {
              utility::flag_set(flagname, other);
            }

            if(endonflag) {
              return;
            }

            wait 2;
          }
        } else {
          time_elapsed = 0;

          if(has_flag) {
            utility::flag_clear(flagname);
          }
        }

        wait debounce;
      }
    }
  }

  function trigger_cansee(trigger) {
    triggers = [];
    target_origin = undefined;
    array = trigger get_trigger_targs();
    triggers = array["\xc8!\x186\x83\x13}\xbc"];
    target_origin = array["N\x04\xf3\x841]\xf0\xe5\r\x9c?\xd6x"];
    has_flag = isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy);
    flagname = undefined;

    if(has_flag) {
      flagname = trigger utility_sp::get_trigger_flag();

      if(!isDefined(level.flag[flagname])) {
        utility::flag_init(flagname);
      }
    } else if(!triggers.size) {
      assert(isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy), "<dev string:x36d>" + trigger.origin + "<dev string:x2c4>");
    }

    trigger endon("\x1e\xfd\xd1\xa2\a");
    range = 12;
    offsets = [];
    offsets[offsets.size] = (0, 0, 0);
    offsets[offsets.size] = (range, 0, 0);
    offsets[offsets.size] = (range * -1, 0, 0);
    offsets[offsets.size] = (0, range, 0);
    offsets[offsets.size] = (0, range * -1, 0);
    offsets[offsets.size] = (0, 0, range);

    for(;;) {
      if(has_flag) {
        utility::flag_clear(flagname);
      }

      trigger waittill("\x91`\xb1\xe7T\x97>", other);
      assert(isPlayer(other), "<dev string:x383>");

      while(level.player istouching(trigger)) {
        if(!other cantraceto(target_origin, offsets)) {
          if(has_flag) {
            utility::flag_clear(flagname);
          }

          wait 0.1;
          continue;
        }

        if(has_flag) {
          utility::flag_set(flagname);
        }

        utility::array_thread(triggers, &utility::send_notify, "\x91`\xb1\xe7T\x97>");
        wait 0.5;
      }
    }
  }

  function cantraceto(target_origin, offsets) {
    for(i = 0; i < offsets.size; i++) {
      if(sighttracepassed(self getEye(), target_origin + offsets[i], 1, self)) {
        return true;
      }
    }

    return false;
  }

  function trigger_unlock(trigger) {
    noteworthy = "Yn\xa3\xeb" + trigger getentitynumber() + "\xf0<Q\xc2\x87G\xcb=";

    if(isDefined(trigger.script_noteworthy)) {
      noteworthy = trigger.script_noteworthy;
    }

    target_triggers = getEntArray(trigger.target, #targetname);
    trigger thread trigger_unlock_death(trigger.target);

    for(;;) {
      utility::array_thread(target_triggers, &utility::trigger_off);
      trigger waittill("\x91`\xb1\xe7T\x97>");
      utility::array_thread(target_triggers, &utility::trigger_on);
      wait_for_an_unlocked_trigger(target_triggers, noteworthy);
      utility_sp::array_notify(target_triggers, "\x97QLr\xb5\xbb");
    }
  }

  function trigger_unlock_death(target) {
    self waittill("\x1e\xfd\xd1\xa2\a");
    target_triggers = getEntArray(target, #targetname);
    utility::array_thread(target_triggers, &utility::trigger_off);
  }

  function wait_for_an_unlocked_trigger(triggers, noteworthy) {
    level endon("ji5\x05\xe2\xf2\xbe3\x89ila ~\x1b\xa8^{\xc6\x18" + noteworthy);
    ent = spawnStruct();

    for(i = 0; i < triggers.size; i++) {
      triggers[i] thread report_trigger(ent, noteworthy);
    }

    ent waittill("\x91`\xb1\xe7T\x97>");
    level notify("ji5\x05\xe2\xf2\xbe3\x89ila ~\x1b\xa8^{\xc6\x18" + noteworthy);
  }

  function report_trigger(ent, noteworthy) {
    self endon("\x97QLr\xb5\xbb");
    level endon("ji5\x05\xe2\xf2\xbe3\x89ila ~\x1b\xa8^{\xc6\x18" + noteworthy);
    self waittill("\x91`\xb1\xe7T\x97>");
    ent notify("\x91`\xb1\xe7T\x97>");
  }

  function trigger_battlechatter(trigger) {
    realtrigger = undefined;

    if(isDefined(trigger.target)) {
      targetents = getEntArray(trigger.target, #targetname);

      if(issubstr(targetents[0].classname, "\x91`\xb1\xe7T\x97>")) {
        realtrigger = targetents[0];
      }
    }

    if(isDefined(realtrigger)) {
      realtrigger waittill("\x91`\xb1\xe7T\x97>", other);
    } else {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);
    }

    soldier = undefined;

    if(isDefined(realtrigger)) {
      if(other.team != level.player.team && level.player istouching(trigger)) {
        soldier = level.player battlechatter::getclosestfriendlyspeaker("_\x81\xbc\xed\xbf\x02");
      } else if(other.team == level.player.team) {
        enemyteam = "?\xb1\xc0\x9a";

        if(level.player.team == "?\xb1\xc0\x9a") {
          enemyteam = "O\x15\x1b\xad\x9ff";
        }

        soldiers = battlechatter::getspeakers(enemyteam);
        soldiers = utility::get_array_of_farthest(level.player.origin, soldiers);

        foreach(guy in soldiers) {
          if(guy istouching(trigger)) {
            soldier = guy;

            if(battlechatter_dist_check(guy.origin)) {
              break;
            }
          }
        }
      }
    } else if(isPlayer(other)) {
      soldier = other battlechatter::getclosestfriendlyspeaker("_\x81\xbc\xed\xbf\x02");
    } else {
      soldier = other;
    }

    if(!isDefined(soldier)) {
      return;
    }

    if(battlechatter_dist_check()) {
      return;
    }

    success = soldier utility_sp::custom_battlechatter(trigger.script_bctrigger);

    if(!success) {
      level utility::delaythread(0.25, &trigger_battlechatter, trigger);
      return;
    }

    trigger notify("7\x13\x1b\xd9\xd9\x13]\xb9Jx\xe5\xe2\xcccu\xde\xc0\tcR\xce7@3\x83");
  }

  function battlechatter_dist_check(origin) {
    return distancesquared(origin, level.player getorigin()) <= 262144;
  }

  function trigger_dooropen(trigger) {
    trigger waittill("\x91`\xb1\xe7T\x97>");
    targets = getEntArray(trigger.target, #targetname);
    rotations = [];
    rotations["\x8dV3\xe8}d\xdb\xb7\xe4"] = -170;
    rotations["N1\x02ctN\x10\xfb\xbdA"] = 170;

    foreach(door in targets) {
      assert(isDefined(door.script_noteworthy), "<dev string:x3c5>");
      rotation = rotations[door.script_noteworthy];
      door connectpaths();
      door rotateYaw(rotation, 1, 0, 0.5);
    }
  }

  function trigger_glass_break(trigger) {
    glassid = getglassarray(trigger.target);
    type = "\xab\xc22T\x19g@\xf0\xef";

    if(isDefined(trigger.script_type)) {
      type = "\x91`\xb1\xe7T\x97>";
    }

    if(!isDefined(glassid) || glassid.size == 0) {
      assertmsg("<dev string:x425>" + trigger.origin + "<dev string:x449>");
      return;
    }

    other = undefined;

    while(true) {
      if(type == "\xab\xc22T\x19g@\xf0\xef") {
        level waittill("\x83\xd4}G}wh\xbaXq5", other);
      } else {
        trigger waittill("\x91`\xb1\xe7T\x97>", other);
      }

      if(other istouching(trigger)) {
        ref1 = other.origin;
        waitframe();
        ref2 = other.origin;
        direction = undefined;

        if(ref1 != ref2) {
          direction = ref2 - ref1;
        }

        if(isDefined(direction)) {
          foreach(glass in glassid) {
            destroyglass(glass, direction);
          }

          break;
        }

        foreach(glass in glassid) {
          destroyglass(glass);
        }

        break;
      }
    }

    trigger delete();
  }

  function trigger_delete_link_chain(trigger) {
    trigger waittill("\x91`\xb1\xe7T\x97>");
    targets = trigger get_script_linkto_targets();
    utility::array_thread(targets, &delete_links_then_self);
  }

  function get_script_linkto_targets() {
    targets = [];

    if(!isDefined(self.script_linkto)) {
      return targets;
    }

    tokens = strtok(self.script_linkto, "\xda");

    for(i = 0; i < tokens.size; i++) {
      token = tokens[i];
      target = getEnt(token, #script_linkname);

      if(isDefined(target)) {
        targets[targets.size] = target;
      }
    }

    return targets;
  }

  function delete_links_then_self() {
    targets = get_script_linkto_targets();
    utility::array_thread(targets, &delete_links_then_self);
    self delete();
  }

  function trigger_throw_grenade_at_player(trigger) {
    trigger endon("\x1e\xfd\xd1\xa2\a");
    trigger waittill("\x91`\xb1\xe7T\x97>");
    utility_sp::throwgrenadeatplayerasap();
  }

  function trigger_hint(trigger) {
    assert(isDefined(trigger.script_hint), "<dev string:x46b>" + trigger.origin + "<dev string:x47f>");

    if(!isDefined(level.displayed_hints)) {
      level.displayed_hints = [];
    }

    waittillframeend();
    assert(isDefined(level.trigger_hint_string), "<dev string:x497>");
    hint = trigger.script_hint;
    assert(isDefined(level.trigger_hint_string[hint]), "<dev string:x4c5>" + hint + "<dev string:x4e0>");
    trigger waittill("\x91`\xb1\xe7T\x97>", other);
    assert(isPlayer(other), "<dev string:x532>");

    if(isDefined(level.displayed_hints[hint])) {
      return;
    }

    level.displayed_hints[hint] = 1;
    other utility_sp::display_hint(hint);
  }

  function trigger_delete_on_touch(trigger) {
    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);

      if(isDefined(other)) {
        other delete();
      }
    }
  }

  function trigger_turns_off(trigger) {
    trigger waittill("\x91`\xb1\xe7T\x97>");
    trigger utility::trigger_off();

    if(!isDefined(trigger.script_linkto)) {
      return;
    }

    tokens = strtok(trigger.script_linkto, "\xda");

    for(i = 0; i < tokens.size; i++) {
      utility::array_thread(getEntArray(tokens[i], #script_linkname), &utility::trigger_off);
    }
  }

  function trigger_ignore(trigger) {
    thread trigger_runs_function_on_touch(trigger, &ai::set_ignoreme, &ai::get_ignoreme);
  }

  function trigger_pacifist(trigger) {
    thread trigger_runs_function_on_touch(trigger, &utility_sp::set_pacifist, &utility_sp::get_pacifist);
  }

  function trigger_runs_function_on_touch(trigger, set_func, get_func) {
    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);

      if(!isalive(other)) {
        continue;
      }

      if(other[[get_func]]()) {
        continue;
      }

      other thread touched_trigger_runs_func(trigger, set_func);
    }
  }

  function touched_trigger_runs_func(trigger, set_func) {
    self endon("\x1e\xfd\xd1\xa2\a");
    [[set_func]](1);
    self.ignoretriggers = 1;
    wait 1;
    self.ignoretriggers = 0;

    while(self istouching(trigger)) {
      wait 1;
    }

    [[set_func]](0);
  }

  function trigger_radio(trigger) {
    trigger waittill("\x91`\xb1\xe7T\x97>");
    utility_sp::radio_dialogue(trigger.script_noteworthy);
  }

  function trigger_flag_set_player(trigger) {
    flag = trigger utility_sp::get_trigger_flag();

    if(!isDefined(level.flag[flag])) {
      utility::flag_init(flag);
    }

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);

      if(!isPlayer(other)) {
        continue;
      }

      trigger utility::script_delay();
      utility::flag_set(flag);
    }
  }

  function trigger_multiple_depthoffield(trigger) {
    waittillframeend();

    while(true) {
      trigger waittill("\x91`\xb1\xe7T\x97>", player);
      nearstart = trigger.script_dof_near_start;
      nearend = trigger.script_dof_near_end;
      nearblur = trigger.script_dof_near_blur;
      farstart = trigger.script_dof_far_start;
      farend = trigger.script_dof_far_end;
      farblur = trigger.script_dof_far_blur;
      time = trigger.script_delay;

      if(nearstart != level.dof["z\xd4mN"]["\x83\xd6\xaf\x11"]["\xe6\x95a\xe4\xa9\x1d\x85\x9c\xd1"] || nearend != level.dof["z\xd4mN"]["\x83\xd6\xaf\x11"]["ob\x14J\x84\x02\x9d"] || nearblur != level.dof["z\xd4mN"]["\x83\xd6\xaf\x11"]["9\x90\xb5\xe7u\tV\xd4"] || farstart != level.dof["z\xd4mN"]["\x83\xd6\xaf\x11"]["3X\x9c\xa6\xd1a\xe4\xa3"] || farend != level.dof["z\xd4mN"]["\x83\xd6\xaf\x11"][":\x80A!tU"] || farblur != level.dof["z\xd4mN"]["\x83\xd6\xaf\x11"]["\xd4\x12\x1b\x8d\x1a\v\xb8"]) {
        art::dof_set_base(nearstart, nearend, nearblur, farstart, farend, farblur, time);
        wait time;
        continue;
      }

      waitframe();
    }
  }

  function trigger_multiple_tessellationcutoff(trigger) {
    waittillframeend();

    while(true) {
      trigger waittill("\x91`\xb1\xe7T\x97>", player);
      cutoff_distance = trigger.script_tess_distance;
      cutoff_falloff = trigger.script_tess_falloff;
      time = trigger.script_delay;

      if(cutoff_distance != level.tess.cutoff_distance_goal || cutoff_falloff != level.tess.cutoff_falloff_goal) {
        cutoff_distance = max(0, cutoff_distance);
        cutoff_distance = min(10000, cutoff_distance);
        cutoff_falloff = max(0, cutoff_falloff);
        cutoff_falloff = min(10000, cutoff_falloff);
        art::tess_set_goal(cutoff_distance, cutoff_falloff, time);
        continue;
      }

      waitframe();
    }
  }

  function trigger_multiple_fx_volume(trigger) {
    dummy = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
    trigger.fx = [];

    foreach(entfx in level.createfxent) {
      assign_fx_to_trigger(entfx, trigger, dummy);
    }

    dummy delete();

    if(!isDefined(trigger.target)) {
      return;
    }

    targets = getEntArray(trigger.target, #targetname);
    trigger.fx_on = 1;

    foreach(target in targets) {
      switch (target.classname) {
        case #"hash_3507493b67792336":
          target thread trigger_multiple_fx_trigger_on_think(trigger);
          break;
        case #"hash_f3b48883e3c60578":
          target thread trigger_multiple_fx_trigger_off_think(trigger);
          break;
        default:
          break;
      }
    }
  }

  function trigger_multiple_fx_trigger_on_think(volume) {
    while(true) {
      self waittill("\x91`\xb1\xe7T\x97>");

      if(!volume.fx_on) {
        utility::array_thread(volume.fx, &utility_sp::restarteffect);
      }

      wait 1;
    }
  }

  function trigger_multiple_fx_trigger_off_think(volume) {
    while(true) {
      self waittill("\x91`\xb1\xe7T\x97>");

      if(volume.fx_on) {
        utility::array_thread(volume.fx, &utility::pauseeffect);
      }

      wait 1;
    }
  }

  function assign_fx_to_trigger(entfx, trigger, dummy) {
    if(isDefined(entfx.v["\x05\xcc,L$\xab\xe9\xc0bw"]) && entfx.v["\x05\xcc,L$\xab\xe9\xc0bw"] != "\xb8\x96g") {
      if(!isDefined(entfx.v["Q*\xe2\xa2\xbb\x15\x8c\x02"]) || !entfx.v["Q*\xe2\xa2\xbb\x15\x8c\x02"]) {
        return;
      }
    }

    dummy.origin = entfx.v["\xb0$R\x8b\xc9\x17"];

    if(dummy istouching(trigger)) {
      trigger.fx[trigger.fx.size] = entfx;
    }
  }

  function trigger_multiple_compass(trigger) {
    minimap_image = trigger.script_parameters;
    assert(isDefined(minimap_image), "<dev string:x567>");

    if(!isDefined(level.minimap_image)) {
      level.minimap_image = "";
    }

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>");

      if(level.minimap_image != minimap_image) {
        compass::setupminimap(minimap_image);
      }
    }
  }

  function trigger_no_crouch_or_prone(trigger) {
    utility::array_thread(level.players, &no_crouch_or_prone_think_for_player, trigger);
  }

  function no_crouch_or_prone_think_for_player(trigger) {
    assert(isPlayer(self));

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", player);

      if(!isDefined(player)) {
        continue;
      }

      if(player != self) {
        continue;
      }

      while(player istouching(trigger)) {
        player allowprone(0);
        player allowcrouch(0);
        wait 0.05;
      }

      player allowprone(1);
      player allowcrouch(1);
    }
  }

  function trigger_no_prone(trigger) {
    utility::array_thread(level.players, &no_prone_for_player, trigger);
  }

  function no_prone_for_player(trigger) {
    assert(isPlayer(self));

    for(;;) {
      trigger waittill("\x91`\xb1\xe7T\x97>", player);

      if(!isDefined(player)) {
        continue;
      }

      if(player != self) {
        continue;
      }

      while(player istouching(trigger)) {
        player allowprone(0);
        wait 0.05;
      }

      player allowprone(1);
    }
  }

  function exploder_load(trigger) {
    level endon("\fe\xafX\xf0\xa0\xc1\xcc?\xa2\xbfDS\xbc\x13\x96\x9c)\xb7\xc4" + trigger.script_exploder);
    trigger waittill("\x91`\xb1\xe7T\x97>");

    if(isDefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance) {
      if(!trigger utility::script_delay()) {
        wait 4;
      }

      level thread exploder_load(trigger);
      return;
    }

    if(!trigger utility::script_delay() && isDefined(trigger.script_exploder_delay)) {
      wait trigger.script_exploder_delay;
    }

    utility::exploder(trigger.script_exploder);
    level notify("\fe\xafX\xf0\xa0\xc1\xcc?\xa2\xbfDS\xbc\x13\x96\x9c)\xb7\xc4" + trigger.script_exploder);
  }

  function trigger_multiple_kleenex(trigger) {
    if(getdvarint(@ "kleenex") != 1) {
      return;
    }

    trigger waittill("\x91`\xb1\xe7T\x97>");
    utility_sp::kleenex_popup();
  }

  function trigger_stealth_shadow(trigger) {
    trigger endon("\x1e\xfd\xd1\xa2\a");
    the_flag = "v8\xde\xcb\x1a\x8b>w\xac\xf2sJ\xfd_\xf3\xe4\x8f";

    if(!isDefined(level.trigger_stealth_shadow)) {
      level.trigger_stealth_shadow = [];
    }

    level.trigger_stealth_shadow[level.trigger_stealth_shadow.size] = trigger;
    function_31e75b0c3f4a0d2c(trigger);

    while(true) {
      trigger waittill("\x91`\xb1\xe7T\x97>", other);

      if(!other utility::ent_flag_exist(the_flag)) {
        println("<dev string:x5b3>" + the_flag + "<dev string:x5b9>" + other getentnum() + "<dev string:x5dc>");
        continue;
      }

      if(other utility::ent_flag(the_flag)) {
        continue;
      }

      other thread in_shadow_thread(trigger, the_flag);
    }
  }

  function in_shadow_thread(volume, the_flag) {
    self endon("\x1e\xfd\xd1\xa2\a");
    player::function_d08bc3b308232c9d(the_flag);

    while(isDefined(volume) && self istouching(volume)) {
      wait 0.05;
    }

    player::function_c174a04e30f56398(the_flag);
  }

  function trigger_fire(trigger) {
    trigger endon("\x1e\xfd\xd1\xa2\a");

    if(isDefined(trigger.trigger_fire_endon)) {
      trigger endon(trigger.trigger_fire_endon);
    }

    default_damage = 1;
    dam_multiplier = 5;
    final_damage = 0;

    if(!isDefined(trigger.script_delay_min) && !isDefined(trigger.script_delay_max)) {
      trigger.script_delay_min = 0.05;
      trigger.script_delay_max = 0.05;
    }

    if(trigger.script_delay_min == trigger.script_delay_max) {
      trigger.script_delay = trigger.script_delay_min;
    }

    if(isDefined(trigger.script_damage)) {
      default_damage = trigger.script_damage;
    }

    while(true) {
      trigger waittill("\x91`\xb1\xe7T\x97>", victim);
      center_point = trigger.origin;

      if(isPlayer(victim)) {
        final_damage = default_damage;

        if(trigger.classname == "\x87\xeb\xee\x9e\xf6\xa0;\tN'\xc7s\x9c\x0e\x170^\xb3u") {
          if(isDefined(trigger.script_radius)) {
            if(distance2dsquared(victim.origin, trigger.origin) <= squared(trigger.script_radius)) {
              if(isDefined(trigger.script_multiplier) && isnumber(trigger.script_multiplier)) {
                dam_multiplier = trigger.script_multiplier;
              }

              final_damage *= dam_multiplier;
            }
          }
        } else if(isDefined(trigger.target)) {
          struct = utility::getStruct(trigger.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
          center_point = struct.origin;

          if(isDefined(struct.script_radius)) {
            if(distance2dsquared(victim.origin, struct.origin) <= squared(struct.script_radius)) {
              if(isDefined(trigger.script_multiplier) && isnumber(trigger.script_multiplier)) {
                dam_multiplier = trigger.script_multiplier;
              }

              final_damage *= dam_multiplier;
            }
          }
        }
      }

      if(istrue(victim.damageshield)) {
        continue;
      }

      victim utility_sp::do_damage(final_damage, center_point, undefined, undefined, "\b\x89z\xc1\xf1\xd4I\xf3");

      if(final_damage < 6) {
        victim playRumbleOnEntity("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
      } else {
        victim playRumbleOnEntity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
      }

      trigger utility::script_delay();
    }
  }

  function trigger_multiple_fx(trigger) {
    if(trigger.classname == "\xc4\x19\xda\x04\xc8\xd2;@Y\xf5\xf2Xt\xf99LS1\xc8E\xf3\xb5") {
      bool = &fx::struct_fx_inactive;
      func = &fx::play_struct_fx;
    } else {
      bool = &fx::struct_fx_active;
      func = &fx::stop_struct_fx;
    }

    while(true) {
      trigger waittill("\x91`\xb1\xe7T\x97>");

      foreach(struct in level.struct_fx) {
        if([[bool]](struct) && struct.script_fxgroup == trigger.script_fxgroup) {
          [[func]](struct);
        }
      }
    }
  }

  function trigger_outofbounds(trigger, var_731b52fa27728c91) {
    if(!isDefined(trigger.target)) {
      iprintln("<dev string:x5fa>" + int(trigger.origin[0]) + "<dev string:x61b>" + int(trigger.origin[1]) + "<dev string:x61b>" + int(trigger.origin[2]) + "<dev string:x621>");
    }

    if(isDefined(trigger.target)) {
      trigger.failtrigger = getEnt(trigger.target, #targetname);
    }

    trigger endon("\x1e\xfd\xd1\xa2\a");
    level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
    var_2bf547b1f820ef40 = trigger.spawnflags & 16;

    if(!isDefined(level.var_3f9e3074dd3a474f)) {
      val::register("\x9cYs2NP\xc5\xf5\xf1\xde\xc2k\x7f", 0, 1, "\x127\xca\x8d3", &function_8852a7912335752d, "~\xa9\xccdcE");
      utility_sp::add_extra_autosave_check("Q\x99:&\\.\xa86\xc4\x1b%", &function_ee9fb13ce68ca2f4, "\x1c\x13\x04P\xfd\\\xbb/\xb0\xedg\xe5Q\xe4\xc00\xcdu\xf8\n\xee&=");
      level.var_df91e6cdbc49571 = hud_management::function_a1a13273e72bfe46("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d");
      level.var_3f9e3074dd3a474f = 1;
    }

    if(!isDefined(level.outofboundstriggers)) {
      level.outofboundstriggers = [];
    }

    level.outofboundstriggers[level.outofboundstriggers.size] = trigger;

    while(true) {
      trigger waittill("\x91`\xb1\xe7T\x97>", ent);
      player_ent = undefined;
      triggerer_ent = ent;

      if(isPlayer(ent)) {
        player_ent = ent;
      } else if(var_2bf547b1f820ef40 && isDefined(ent.driver) && isPlayer(ent.driver)) {
        player_ent = ent.driver;
      }

      if(isDefined(player_ent)) {
        killstreakinfo = player_ent killstreaks::function_db9abbb1cebd0770();

        if(isDefined(killstreakinfo) && !player_ent killstreaks::iskillstreakaffectedbyobb(killstreakinfo)) {
          continue;
        }

        trigger_entnum = trigger getentitynumber();

        if(!isDefined(player_ent.var_79e0e45993608434[trigger_entnum])) {
          player_ent.var_79e0e45993608434[trigger_entnum] = trigger;
          player_ent thread function_de58ddc06fc15ab3(trigger, trigger_entnum, triggerer_ent);
        }
      }
    }
  }

  function private function_de58ddc06fc15ab3(trigger, trigger_entnum, triggerer_ent) {
    self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
    trigger endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
    assert(isPlayer(self));

    if(self.var_79e0e45993608434.size == 1) {
      self notify("W88\x14\xe9\xbc<B\xa0\x01}\xa5\f\xd8p3!");
      val::set("\x04\xa9e", "\x9cYs2NP\xc5\xf5\xf1\xde\xc2k\x7f", 1);
    }

    if(isDefined(trigger.failtrigger)) {
      trigger.failtrigger childthread outofbounds_failthread(triggerer_ent);
    }

    var_2bf547b1f820ef40 = trigger.spawnflags & 16;
    triggervalname = "\xc5\xf0qAPx\xd7r\xaa\x97vY\x9dap\xc5E\xd1A\xc0" + trigger_entnum;
    trigger function_7c4c52fa7b3c84e0(triggervalname, trigger.failtrigger);

    while(isalive(triggerer_ent) && triggerer_ent istouching(trigger)) {
      new_triggerer = undefined;

      if(var_2bf547b1f820ef40 && self isvehicleactive() && isDefined(self.veh)) {
        new_triggerer = self.veh;
      } else {
        new_triggerer = self;
      }

      if(isDefined(new_triggerer) && new_triggerer != triggerer_ent) {
        triggerer_ent = new_triggerer;

        if(isDefined(trigger.failtrigger)) {
          trigger.failtrigger childthread outofbounds_failthread(triggerer_ent);
        }
      }

      waitframe();
    }

    if(isDefined(trigger.failtrigger)) {
      trigger.failtrigger notify("xF\x1c\xa8.A\xb6\x10'\x98tg\xc3\xa2\xb1");
    }

    self.var_79e0e45993608434[trigger_entnum] = undefined;

    if(self.var_79e0e45993608434.size == 0) {
      thread function_d3af9ed480a93bc1();
    }
  }

  function private function_d3af9ed480a93bc1() {
    self endon("W88\x14\xe9\xbc<B\xa0\x01}\xa5\f\xd8p3!");
    wait 2;
    val::reset_all("\x04\xa9e");
  }

  function private function_7c4c52fa7b3c84e0(triggervalname, failtrigger) {
    self notify("eH\xd6%:\xa2\x8dJ\xde}\x85 4\x1c\xee");
    self endon("eH\xd6%:\xa2\x8dJ\xde}\x85 4\x1c\xee");
    thread outofbounds_trigger_death_wait(triggervalname, failtrigger);
  }

  function private function_a031c41ab77711ec(triggervalname, failtrigger) {
    self notify("y\xee\xe1\xb9E\xfeY.\x02}\xb2\v\x9c\xb8\xa2\f");
    self endon("y\xee\xe1\xb9E\xfeY.\x02}\xb2\v\x9c\xb8\xa2\f");

    if(isDefined(self)) {
      self notify("o\xd5:\xdbf\x13\xbd\xea\x9b2n\xf5\xe8N-g\xceYN\xeb#Va\x1d4\xbe\xdd\xc2K\xe8");
    }

    if(isDefined(failtrigger)) {
      failtrigger notify("xF\x1c\xa8.A\xb6\x10'\x98tg\xc3\xa2\xb1");
    }
  }

  function private outofbounds_trigger_death_wait(triggervalname, failtrigger) {
    self notify("\x1f\xf4\xb2\xfaY\x9f\x13\xb5t\x87\x92f\xcad\by");
    self endon("\x1f\xf4\xb2\xfaY\x9f\x13\xb5t\x87\x92f\xcad\by");
    self endon("o\xd5:\xdbf\x13\xbd\xea\x9b2n\xf5\xe8N-g\xceYN\xeb#Va\x1d4\xbe\xdd\xc2K\xe8");
    self waittill("\x1e\xfd\xd1\xa2\a");
    thread function_a031c41ab77711ec(triggervalname, failtrigger);
  }

  function private function_8852a7912335752d(outofbounds = 1) {
    if(outofbounds) {
      level.player val::set("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", "#\x03q\xe2\xec\xfd\r\x1a*q\x91\xadw1O:7g\xb2\xc3/", 1);
      level.player val::set("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", "\xb4\xf8\xd7\x7fGm\xe7<\xf4N\x95}\x1fZ\xe5\xcfy\xc6", 1);

      if(isDefined(level.var_df91e6cdbc49571)) {
        if(!level.player hud_management::function_48c98ea9a4f0da89("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d")) {
          level.player hud_management::function_35924dfcb78711f4("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", level.var_df91e6cdbc49571);
          level.player hud_management::function_85d8a0ba2e35b6f2("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", 0, -190, 1, 1);
          level.player hud_management::function_b683400f784cb7dc("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", "J+t\xd5\xc9s*{5Z\x9b\xcd-o\xcd");
        }

        fields = [];

        if(isDefined(level.player.var_d893fb218a2dfdec)) {
          fields["\xb5\xcd\xd9\xfaZ7FV\x1e"] = function_30e4f86dded0873(level.player.var_d893fb218a2dfdec);
        }

        fields["\xae\x90\xf8^}\x99\xe5p\xb8"] = 1;
        level.player hud_management::function_41ff479ac45608d6("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", fields, 1);
      }

      return;
    }

    if(isDefined(level.var_df91e6cdbc49571) && level.player hud_management::function_73ac92d48ae2a07f(level.var_df91e6cdbc49571)) {
      level.player hud_management::function_d8d634ceece460("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", "\x19b\xc2y");
    }

    level.player function_373f6314c2267498();
  }

  function private function_ee9fb13ce68ca2f4() {
    return !level.player val::get("\x9cYs2NP\xc5\xf5\xf1\xde\xc2k\x7f");
  }

  function isplayeroutofbounds() {
    return level.player val::get("\x9cYs2NP\xc5\xf5\xf1\xde\xc2k\x7f");
  }

  function outofbounds_failthread(trigger_ent) {
    self endon("\x1e\xfd\xd1\xa2\a");
    self endon("xF\x1c\xa8.A\xb6\x10'\x98tg\xc3\xa2\xb1");
    trigger_ent notify("-sF\x8dM\xe3\x91\xa4\x95\xa3+\xae\xcd\x15\x92-\xdf\x12g\x10\x1frED\xb4\xd4{");
    trigger_ent endon("-sF\x8dM\xe3\x91\xa4\x95\xa3+\xae\xcd\x15\x92-\xdf\x12g\x10\x1frED\xb4\xd4{");
    ent = undefined;

    while(!isDefined(ent) || trigger_ent != ent) {
      self waittill("\x91`\xb1\xe7T\x97>", ent);
    }

    level.player hud_management::scripted_widget_destroy("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d");
    setomnvar("\xd9\xa9\xb7\xaac\xd4\xa5{\x8eqp@)hQ\x17\xe7\xd8\x0fJ\xcf\xe6\x12\x13\xd8\xbf", 0);

    if(level.player utility::isusingremote()) {
      level.player notify("\xda\xd2l\x1b\xd7\xf6{\x89\xafr+k\xbdG\xac\xfa;\x95h\x96c\xc6+");
      return;
    }

    var_b22705fa3ffc814c = isDefined(level.var_e5e88b34ad3a2bce) ? level.var_e5e88b34ad3a2bce : % "hash_1408c63ee5ac4dbe";
    player_death::set_custom_death_quote(var_b22705fa3ffc814c);
    level.player val::set("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", "\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", 0);
    utility_sp::missionfailedwrapper("Y\x99:\x06\\&\xa86\xc4\x1b%");
  }

  function function_373f6314c2267498() {
    level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

    if(hud_management::function_48c98ea9a4f0da89("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d")) {
      hud_management::function_d8d634ceece460("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d", "\x19b\xc2y");

      if(isDefined(level.var_36cf133a29bf502f)) {
        pbgpostfxbundleend(self, level.var_36cf133a29bf502f);
        level.var_36cf133a29bf502f = undefined;
      }
    }

    val::reset_all("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d");
  }

  function function_bd5c661e1bf090e() {
    hud_management::scripted_widget_destroy("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d");
    val::reset_all("\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xf5\xe3C\xcf`\xa0\xd6\xee\x1a\x95\xf7I\x9d");
    player_death::set_custom_death_quote(%"hash_1408c63ee5ac4dbe");
    utility_sp::missionfailedwrapper("Y\x99:\x06\\&\xa86\xc4\x1b%");
  }