/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_sq_bttp.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\zm_temple_sq;
#using scripts\zm\zm_temple_sq_brock;
#using scripts\zm\zm_temple_sq_skits;
#namespace zm_temple_sq_bttp;

function init() {
  zm_sidequests::declare_sidequest_stage("sq", "bttp", &init_stage, &stage_logic, &exit_stage);
  zm_sidequests::set_stage_time_limit("sq", "bttp", 300);
  zm_sidequests::declare_stage_asset_from_struct("sq", "bttp", "sq_bttp_glyph", undefined, &function_8feeec3c);
}

function init_stage() {
  if(isDefined(level._sq_skel)) {
    level._sq_skel ghost();
  }
  level.var_5f315f0b = 0;
  zm_temple_sq_brock::delete_radio();
  var_b28c3b10 = getEntArray("sq_spiketrap", "targetname");
  array::thread_all(var_b28c3b10, &function_d0295ce3);
  level thread delayed_start_skit();
}

function delayed_start_skit() {
  wait(0.5);
  level thread zm_temple_sq_skits::start_skit("tt6");
}

function trap_trigger() {
  level endon("hash_20531487");
  while(true) {
    self waittill("damage", amount, attacker, direction, point, dmg_type, modelname, tagname);
    if(isPlayer(attacker) && (dmg_type == "MOD_EXPLOSIVE" || dmg_type == "MOD_EXPLOSIVE_SPLASH" || dmg_type == "MOD_GRENADE" || dmg_type == "MOD_GRENADE_SPLASH")) {
      self.owner_ent notify("triggered", attacker);
      return;
    }
  }
}

function function_d0295ce3() {
  level endon("hash_20531487");
  self.trigger = spawn("trigger_damage", self.origin, 0, 32, 72);
  self.trigger.height = 72;
  self.trigger.radius = 32;
  self.trigger.owner_ent = self;
  self.trigger thread trap_trigger();
  self waittill("triggered", who);
  who thread zm_audio::create_and_play_dialog("eggs", "quest1", 7);
  self.trigger playSound("evt_sq_bttp_wood_explo");
  self ghost();
  level flag::set("trap_destroyed");
}

function function_e3bf4adb() {
  self endon("death");
  self endon("done");
  level endon("hash_20531487");
  while(!(isDefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
    print3d(self.origin, "", vectorscale((0, 0, 1), 255), 1);
    wait(0.1);
  }
}

function function_8feeec3c() {
  hits = 0;
  self thread function_e3bf4adb();
  while(true) {
    self waittill("damage", amount, attacker, dir, point, type);
    self playSound("evt_sq_bttp_carve");
    if(type == "MOD_MELEE") {
      hits++;
      if(hits >= 1) {
        break;
      }
    }
  }
  self setModel(self.tile);
  self notify("done");
  level.var_5f315f0b++;
  if(isDefined(attacker) && isPlayer(attacker)) {
    if(level.var_5f315f0b < level.var_13439433) {
      if(randomintrange(0, 101) <= 75) {
        attacker thread zm_audio::create_and_play_dialog("eggs", "quest6", randomintrange(0, 4));
      }
    } else {
      attacker thread zm_audio::create_and_play_dialog("eggs", "quest6", 4);
    }
  }
}

function function_87175782(tile) {
  retval = "p_ztem_glyphs_01_unfinished";
  switch (tile) {
    case "p7_zm_sha_glyph_stone_01_unlit": {
      retval = "p7_zm_sha_glyph_stone_01";
      break;
    }
    case "p7_zm_sha_glyph_stone_02_unlit": {
      retval = "p7_zm_sha_glyph_stone_02";
      break;
    }
    case "p7_zm_sha_glyph_stone_03_unlit": {
      retval = "p7_zm_sha_glyph_stone_03";
      break;
    }
    case "p7_zm_sha_glyph_stone_04_unlit": {
      retval = "p7_zm_sha_glyph_stone_04";
      break;
    }
    case "p7_zm_sha_glyph_stone_05_unlit": {
      retval = "p7_zm_sha_glyph_stone_05";
      break;
    }
    case "p7_zm_sha_glyph_stone_06_unlit": {
      retval = "p7_zm_sha_glyph_stone_06";
      break;
    }
    case "p7_zm_sha_glyph_stone_07_unlit": {
      retval = "p7_zm_sha_glyph_stone_07";
      break;
    }
    case "p7_zm_sha_glyph_stone_08_unlit": {
      retval = "p7_zm_sha_glyph_stone_08";
      break;
    }
    case "p7_zm_sha_glyph_stone_09_unlit": {
      retval = "p7_zm_sha_glyph_stone_09";
      break;
    }
    case "p7_zm_sha_glyph_stone_10_unlit": {
      retval = "p7_zm_sha_glyph_stone_10";
      break;
    }
    case "p7_zm_sha_glyph_stone_11_unlit": {
      retval = "p7_zm_sha_glyph_stone_11";
      break;
    }
    case "p7_zm_sha_glyph_stone_12_unlit": {
      retval = "p7_zm_sha_glyph_stone_12";
      break;
    }
  }
  return retval;
}

function stage_logic() {
  level endon("hash_20531487");
  tile_models = array("p7_zm_sha_glyph_stone_01_unlit", "p7_zm_sha_glyph_stone_02_unlit", "p7_zm_sha_glyph_stone_03_unlit", "p7_zm_sha_glyph_stone_04_unlit", "p7_zm_sha_glyph_stone_05_unlit", "p7_zm_sha_glyph_stone_06_unlit", "p7_zm_sha_glyph_stone_07_unlit", "p7_zm_sha_glyph_stone_08_unlit", "p7_zm_sha_glyph_stone_09_unlit", "p7_zm_sha_glyph_stone_10_unlit", "p7_zm_sha_glyph_stone_11_unlit", "p7_zm_sha_glyph_stone_12_unlit");
  tile_models = array::randomize(tile_models);
  ents = getEntArray("sq_bttp_glyph", "targetname");
  level.var_13439433 = ents.size;
  for(i = 0; i < ents.size; i++) {
    ents[i].tile = function_87175782(tile_models[i]);
    ents[i] setModel(tile_models[i]);
  }
  while(true) {
    if(level.var_5f315f0b == ents.size) {
      break;
    }
    wait(0.1);
  }
  level flag::wait_till("trap_destroyed");
  level notify("suspend_timer");
  wait(5);
  zm_sidequests::stage_completed("sq", "bttp");
}

function exit_stage(success) {
  var_b28c3b10 = getEntArray("sq_spiketrap", "targetname");
  if(success) {
    zm_temple_sq::remove_skel();
    zm_temple_sq_brock::create_radio(7, &zm_temple_sq_brock::radio7_override);
  } else {
    if(isDefined(level._sq_skel)) {
      level._sq_skel show();
    }
    zm_temple_sq_brock::create_radio(6);
    foreach(e_trap in var_b28c3b10) {
      e_trap show();
    }
    level thread zm_temple_sq_skits::fail_skit();
  }
  foreach(e_trap in var_b28c3b10) {
    if(isDefined(e_trap.trigger)) {
      e_trap.trigger delete();
    }
  }
}