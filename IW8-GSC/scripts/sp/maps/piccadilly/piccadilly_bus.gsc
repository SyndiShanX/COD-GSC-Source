/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\piccadilly\piccadilly_bus.gsc
*********************************************************/

function start() {
  scripts\engine\sp\utility::set_start_location("bus_start", [level.player]);
}

function main() {
  scripts\engine\sp\utility::autosave_by_name("bus");
  setup_end_bus(level);
  level waittill("forever");
}

function catchup() {}

function setup_end_bus() {
  waitframe();
  var0 = getscriptablearray("end_bus", "script_noteworthy")[0];
  thread open_bus_doors();
  level.end_bus_bomber = scripts\sp\maps\piccadilly\piccadilly_util::picc_spawn_ai("end_bus_bomber");
  thread bus_terrorist(level.end_bus_bomber);
  var1 = [];

  for(var2 = 0; var2 < 22; var2++) {
    if(var2 < 10) {
      var3 = "piccadilly_bus_civ_0";
    } else {
      var3 = "piccadilly_bus_civ_";
    }

    var4 = var0 scripts\sp\maps\piccadilly\piccadilly_civs::spawn_civ("random", 1);
    var4.animname = var3 + int(var2);
    var4 notsolid();
    thread bus_anim(var4);
    var1 = scripts\engine\utility::array_add(var1, var4);
  }
}

#using_animtree("scriptables");

function open_bus_doors() {
  self setanim(%piccadilly_london_bus_combat_door_open_front);
}

function bus_terrorist(var0) {
  self endon("death");
  self.animname = "bus_terrorist";
  thread bus_terrorist_success();
  var0 thread scripts\common\anim::anim_single_solo(self, "bus_scene");
  var1 = getanimlength(scripts\engine\utility::getanim("bus_scene"));

  if(var1 > 20) {
    var1 = 1 - (var1 - 3) / var1;
    self setanimtime(scripts\engine\utility::getanim("bus_scene"), var1);
  }

  while(!scripts\engine\utility::flag("player_on_bus")) {
    waitframe();
  }

  var2 = getanimlength(scripts\engine\utility::getanim("bus_scene"));
  var1 = var2 - var1;

  if(var1 > 20) {
    self setanimtime(scripts\engine\utility::getanim("bus_scene"), 20 / var1);
    return;
  }
}

function bus_anim(var0) {
  self endon("death");
  var0 thread scripts\common\anim::anim_single_solo(self, "bus_scene");
  var1 = getanimlength(scripts\engine\utility::getanim("bus_scene"));

  if(var1 > 20) {
    var1 = 1 - (var1 - 3) / var1;
    self setanimtime(scripts\engine\utility::getanim("bus_scene"), var1);
  }

  while(!scripts\engine\utility::flag("player_on_bus")) {
    waitframe();
  }

  var2 = getanimlength(scripts\engine\utility::getanim("bus_scene"));
  var1 = var2 - var1;

  if(var1 > 20) {
    self setanimtime(scripts\engine\utility::getanim("bus_scene"), 20 / var1);
    return;
  }
}

function bus_dialogue() {
  var0 = getspawner("bus_terrorist", "targetname");
  var1 = var0.origin;
  var2 = scripts\engine\utility::spawn_tag_origin(var1);
  thread bus_terrorist_dialogue(var2);
  level.alpha2 scripts\engine\utility::delaythread(3.3, &scripts\engine\sp\utility::smart_dialogue, "alpha2_noshot");
  level waittill("bus_terrorist_killed");
  thread scripts\engine\utility::play_sound_in_space("pic_bus_bodyfall", (670, -1160, 133));
  wait 0.1;
  var2 delete();
}

function bus_terrorist_dialogue(var0) {
  wait 2;

  if(isDefined(var0)) {
    var0 scripts\engine\sp\utility::play_sound_on_tag("mam_takeout", undefined, 1);
  }

  if(isDefined(var0)) {
    var0 scripts\engine\sp\utility::play_sound_on_tag("mam_fordecades", undefined, 1);
  }

  scripts\engine\utility::flag_wait("player_on_bus");

  if(isDefined(var0)) {
    var0 scripts\engine\sp\utility::play_sound_on_tag("mam_youintervene", undefined, 1);
  }

  if(isDefined(var0)) {
    var0 scripts\engine\sp\utility::play_sound_on_tag("mam_notsafe", undefined, 1);
    return;
  }
}

function bus_terrorist_success() {
  self endon("death");
  scripts\engine\utility::flag_wait("player_on_bus");
  level scripts\engine\sp\utility::nextmission_primeloadbink();
  var0 = ["j_helmet", "j_head"];

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8);

    if(!isDefined(var2)) {
      continue;
    }

    if(isDefined(var8) && scripts\engine\utility::array_contains(var0, var8) && var2 == level.player) {
      thread piccadilly_finished();
      scripts\asm\asm_sp::asm_stopanimcustom();
      scripts\engine\sp\utility::anim_stopanimScripted();
      scripts\engine\sp\utility::die();
    }
  }
}

function bus_terrorist_explode(var0) {}

function piccadilly_finished() {
  var0 = getscriptablearray("end_bus", "script_noteworthy")[0];
  wait 3;
  level.player scripts\sp\hud_util::fade_out(3, "black");
  scripts\engine\sp\utility::nextmission();
}