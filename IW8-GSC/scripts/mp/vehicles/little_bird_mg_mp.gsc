/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\little_bird_mg_mp.gsc
*****************************************************/

function blockade_gate_explode_sequence(var_0, var_1) {
  self endon("death");
  bomb_sites_spawn(var_1);
  var_2 = "ascender_" + var_0 + "_in";
  var_3 = "ascender_" + var_0 + "_loop";
  var_4 = "ascender_" + var_0 + "_out";
  var_5 = "wm_eq_ascender_" + var_0 + "_get_on_ascender";
  var_6 = "wm_eq_ascender_" + var_0 + "_loop_ascender";
  var_7 = "wm_eq_ascender_" + var_0 + "_get_off_ascender";
  thread ref_12b4e(var_1);
  var_8 = blockade_barbwires(var_2, var_1);
  var_8.mp_backlot2_patch = scripts\engine\utility::getStruct(var_1.target, "targetname");
  ref_13baa(1, var_8);
  thread blinking_light_thread(var_2, var_4, var_3, var_5, var_7, var_6, var_8, var_1, var_0);
  var_1.inuse = 0;
  scripts\engine\utility::ref_143a5("ascended", "death");
}

function bomb_sites_spawn(var_0) {
  self.ignoreall = 1;
  self.goalradius = 96;
  self setgoalpos(self getclosestreachablepointonnavmesh(var_0.origin));

  while(istrue(var_0.inuse)) {
    wait 0.1;
  }

  var_0.inuse = 1;
}

function ref_12b4e(var_0) {
  self endon("ascended");
  self waittill("death");
  var_0.inuse = 0;
}

function blinking_light_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  var_9 = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", var_0);
  var_10 = scripts\asm\asm::asm_getxanim("animscripted2", var_9);
  var_11 = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", var_1);
  var_12 = scripts\asm\asm::asm_getxanim("animscripted2", var_11);
  var_13 = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", var_2);
  var_14 = scripts\asm\asm::asm_getxanim("animscripted2", var_13);
  self setplayerangles(var_6.angles);

  if(var_8 == "up") {
    self forceteleport(var_6.origin + anglestoleft(var_6.angles) * -4 + anglesToForward(var_6.angles) * 10, var_6.angles);
  } else {
    self forceteleport(var_6.origin + anglestoleft(var_6.angles) * 4, var_6.angles);
  }

  blockade_barrier_clip(var_7);
  thread canplaycircleopendialog();
  blink_train_test(var_3, var_7, var_9, var_6, var_10);
  blink_wheelson_chosen_spawn(var_14, var_6);
  blinkblackoverlay(var_4, var_11, var_12);
  blockade_gate();
  ref_13baa(0);
  self notify("ascended");
}

function blink_train_test(var_0, var_1, var_2, var_3, var_4) {
  self.ascender scriptmodelplayanimdeltamotionfrompos(var_0, var_1.origin, var_1.angles);
  self animmode("noclip");
  self aisetanim("animscripted2", var_2);
  self orientmode("face angle", var_3.angles[1]);
  waitframe();
  self.ascender show();
  wait getanimlength(var_4);
}

function blink_wheelson_chosen_spawn(var_0, var_1) {
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkTo(self.anchor);
  self.ascender linkTo(self.anchor);
  var_2 = getanimlength(var_0);
  self.anchor moveTo(var_1.mp_backlot2_patch.origin, var_2 * 3);
  self.anchor waittill("movedone");
}

function blinkblackoverlay(var_0, var_1, var_2) {
  self unlink();
  self.ascender scriptmodelclearanim();
  self.ascender scriptmodelplayanimdeltamotionfrompos(var_0, self.ascender.origin, self.ascender.angles);
  self aisetanim("animscripted2", var_1);
  wait getanimlength(var_2);
  self.anchor delete();
  self.ascender delete();
}

function blockade_barbwires(var_0, var_1) {
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", var_0);
  var_3 = scripts\asm\asm::asm_getxanim("animscripted2", var_2);
  var_4 = spawnStruct();

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_4.origin = getstartorigin(var_1.origin, var_1.angles, var_3);
  var_4.angles = getstartangles(var_1.origin, var_1.angles, var_3);
  return var_4;
}

function blockade_barrier_clip(var_0) {
  self.old_weapon = self.weapon;
  self.canseecantshoottime = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  self giveweapon(self.canseecantshoottime);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.canseecantshoottime);
  self.ascender = spawn("script_model", var_0.origin);
  self.ascender.angles = var_0.angles;
  self.ascender setModel("misc_wm_ascender");
  self.ascender hide();
}

function blockade_gate() {
  self giveweapon(self.old_weapon);
  self takeweapon(self.canseecantshoottime);
  self setspawnweapon(self.old_weapon);
}

function bloadinghvt(var_0) {
  var_1 = scripts\engine\utility::getStructArray("ascend_begin", "script_noteworthy");
  var_2 = scripts\engine\utility::getclosest(var_0, var_1);
  return var_2;
}

function blockachievementstimestamp(var_0) {
  var_1 = scripts\engine\utility::getStructArray("descend_begin", "script_noteworthy");
  var_2 = scripts\engine\utility::getclosest(var_0, var_1);
  return var_2;
}

function canplaycircleopendialog() {
  self endon("ascended");
  var_0 = self.ascender;
  self.do_immediate_ragdoll = 1;
  self waittill("death");
  var_0 delete();
}

function ref_13baa(var_0, var_1) {
  if(var_0) {
    self.ignoreall = 1;

    if(isDefined(var_1)) {
      self.goalradius = 8;
      self setgoalpos(self getclosestreachablepointonnavmesh(var_1.origin));
      self waittill("goal");
      wait 1;
    }

    scripts\asm\asm_mp::carepackage_get_dropped_entities();
    self.playing_skit = 1;
    return;
  }

  self.goalradius = 4096;
  self.ignoreall = 0;
  scripts\asm\shared\mp\utility::bunkercounteruav();
  self.playing_skit = undefined;
}