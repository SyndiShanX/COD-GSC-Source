/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\piccadilly\piccadilly_bus.gsc
*************************************************/

start() {
  scripts\engine\sp\utility::set_start_location("bus_start", [level.player]);
}

main() {
  scripts\engine\sp\utility::autosave_by_name("bus");
  level setup_end_bus();
  level waittill("forever");
}

catchup() {}

setup_end_bus() {
  waitframe();
  var_0 = getscriptablearray("end_bus", "script_noteworthy")[0];
  var_0 thread open_bus_doors();
  level.end_bus_bomber = scripts\sp\maps\piccadilly\piccadilly_util.gsc::picc_spawn_ai("end_bus_bomber");
  level.end_bus_bomber thread bus_terrorist(var_0);
  var_1 = [];

  for(var_2 = 0; var_2 < 22; var_2++) {
    if(var_2 < 10)
      var_3 = "piccadilly_bus_civ_0";
    else
      var_3 = "piccadilly_bus_civ_";

    var_4 = var_0 scripts\sp\maps\piccadilly\piccadilly_civs.gsc::spawn_civ("random", 1);
    var_4.animname = var_3 + int(var_2);
    var_4 notsolid();
    var_4 thread bus_anim(var_0);
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }
}

#using_animtree("scriptables");

open_bus_doors() {
  self setanim(%piccadilly_london_bus_combat_door_open_front);
}

bus_terrorist(var_0) {
  self endon("death");
  self.animname = "bus_terrorist";
  thread bus_terrorist_success();
  var_0 thread scripts\common\anim::anim_single_solo(self, "bus_scene");
  var_1 = getanimlength(scripts\engine\utility::getanim("bus_scene"));

  if(var_1 > 20) {
    var_1 = 1 - (var_1 - 3) / var_1;
    self setanimtime(scripts\engine\utility::getanim("bus_scene"), var_1);
  }

  while(!scripts\engine\utility::flag("player_on_bus"))
    waitframe();

  var_2 = getanimlength(scripts\engine\utility::getanim("bus_scene"));
  var_1 = var_2 - var_1;

  if(var_1 > 20)
    self setanimtime(scripts\engine\utility::getanim("bus_scene"), 20 / var_1);
}

bus_anim(var_0) {
  self endon("death");
  var_0 thread scripts\common\anim::anim_single_solo(self, "bus_scene");
  var_1 = getanimlength(scripts\engine\utility::getanim("bus_scene"));

  if(var_1 > 20) {
    var_1 = 1 - (var_1 - 3) / var_1;
    self setanimtime(scripts\engine\utility::getanim("bus_scene"), var_1);
  }

  while(!scripts\engine\utility::flag("player_on_bus"))
    waitframe();

  var_2 = getanimlength(scripts\engine\utility::getanim("bus_scene"));
  var_1 = var_2 - var_1;

  if(var_1 > 20)
    self setanimtime(scripts\engine\utility::getanim("bus_scene"), 20 / var_1);
}

bus_dialogue() {
  var_0 = getspawner("bus_terrorist", "targetname");
  var_1 = var_0.origin;
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1);
  thread bus_terrorist_dialogue(var_2);
  level.alpha2 scripts\engine\utility::delaythread(3.3, scripts\engine\sp\utility::smart_dialogue, "alpha2_noshot");
  level waittill("bus_terrorist_killed");
  thread scripts\engine\utility::play_sound_in_space("pic_bus_bodyfall", (670, -1160, 133));
  wait 0.1;
  var_2 delete();
}

bus_terrorist_dialogue(var_0) {
  wait 2;

  if(isDefined(var_0))
    var_0 scripts\engine\sp\utility::play_sound_on_tag("mam_takeout", undefined, 1);

  if(isDefined(var_0))
    var_0 scripts\engine\sp\utility::play_sound_on_tag("mam_fordecades", undefined, 1);

  scripts\engine\utility::flag_wait("player_on_bus");

  if(isDefined(var_0))
    var_0 scripts\engine\sp\utility::play_sound_on_tag("mam_youintervene", undefined, 1);

  if(isDefined(var_0))
    var_0 scripts\engine\sp\utility::play_sound_on_tag("mam_notsafe", undefined, 1);
}

bus_terrorist_success() {
  self endon("death");
  scripts\engine\utility::flag_wait("player_on_bus");
  level scripts\engine\sp\utility::nextmission_primeloadbink();
  var_0 = ["j_helmet", "j_head"];

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(var_8) && scripts\engine\utility::array_contains(var_0, var_8) && var_2 == level.player) {
      level thread piccadilly_finished();
      scripts\asm\asm_sp::asm_stopanimcustom();
      scripts\engine\sp\utility::anim_stopanimScripted();
      scripts\engine\sp\utility::die();
    }
  }
}

bus_terrorist_explode(var_0) {}

piccadilly_finished() {
  var_0 = getscriptablearray("end_bus", "script_noteworthy")[0];
  wait 3;
  level.player scripts\sp\hud_util::fade_out(3, "black");
  scripts\engine\sp\utility::nextmission();
}