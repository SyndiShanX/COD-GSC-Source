/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\little_bird_mg_mp.gsc
*****************************************************/

function blockade_gate_explode_sequence(var0, var1) {
  self endon("death");
  bomb_sites_spawn(var1);
  var2 = "ascender_" + var0 + "_in";
  var3 = "ascender_" + var0 + "_loop";
  var4 = "ascender_" + var0 + "_out";
  var5 = "wm_eq_ascender_" + var0 + "_get_on_ascender";
  var6 = "wm_eq_ascender_" + var0 + "_loop_ascender";
  var7 = "wm_eq_ascender_" + var0 + "_get_off_ascender";
  thread ref_12b4e(var1);
  var8 = blockade_barbwires(var2, var1);
  var8.mp_backlot2_patch = scripts\engine\utility::getStruct(var1.target, "targetname");
  ref_13baa(1, var8);
  thread blinking_light_thread(var2, var4, var3, var5, var7, var6, var8, var1, var0);
  var1.inuse = 0;
  scripts\engine\utility::ref_143a5("ascended", "death");
}

function bomb_sites_spawn(var0) {
  self.ignoreall = 1;
  self.goalradius = 96;
  self setgoalpos(self getclosestreachablepointonnavmesh(var0.origin));

  while(istrue(var0.inuse)) {
    wait 0.1;
  }

  var0.inuse = 1;
}

function ref_12b4e(var0) {
  self endon("ascended");
  self waittill("death");
  var0.inuse = 0;
}

function blinking_light_thread(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  self endon("death");
  var9 = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", var0);
  var10 = scripts\asm\asm::asm_getxanim("animscripted2", var9);
  var11 = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", var1);
  var12 = scripts\asm\asm::asm_getxanim("animscripted2", var11);
  var13 = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", var2);
  var14 = scripts\asm\asm::asm_getxanim("animscripted2", var13);
  self setplayerangles(var6.angles);

  if(var8 == "up") {
    self forceteleport(var6.origin + anglestoleft(var6.angles) * -4 + anglesToForward(var6.angles) * 10, var6.angles);
  } else {
    self forceteleport(var6.origin + anglestoleft(var6.angles) * 4, var6.angles);
  }

  blockade_barrier_clip(var7);
  thread canplaycircleopendialog();
  blink_train_test(var3, var7, var9, var6, var10);
  blink_wheelson_chosen_spawn(var14, var6);
  blinkblackoverlay(var4, var11, var12);
  blockade_gate();
  ref_13baa(0);
  self notify("ascended");
}

function blink_train_test(var0, var1, var2, var3, var4) {
  self.ascender scriptmodelplayanimdeltamotionfrompos(var0, var1.origin, var1.angles);
  self animmode("noclip");
  self aisetanim("animscripted2", var2);
  self orientmode("face angle", var3.angles[1]);
  waitframe();
  self.ascender show();
  wait getanimlength(var4);
}

function blink_wheelson_chosen_spawn(var0, var1) {
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkTo(self.anchor);
  self.ascender linkTo(self.anchor);
  var2 = getanimlength(var0);
  self.anchor moveTo(var1.mp_backlot2_patch.origin, var2 * 3);
  self.anchor waittill("movedone");
}

function blinkblackoverlay(var0, var1, var2) {
  self unlink();
  self.ascender scriptmodelclearanim();
  self.ascender scriptmodelplayanimdeltamotionfrompos(var0, self.ascender.origin, self.ascender.angles);
  self aisetanim("animscripted2", var1);
  wait getanimlength(var2);
  self.anchor delete();
  self.ascender delete();
}

function blockade_barbwires(var0, var1) {
  var2 = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", var0);
  var3 = scripts\asm\asm::asm_getxanim("animscripted2", var2);
  var4 = spawnStruct();

  if(!isDefined(var1.angles)) {
    var1.angles = (0, 0, 0);
  }

  var4.origin = getstartorigin(var1.origin, var1.angles, var3);
  var4.angles = getstartangles(var1.origin, var1.angles, var3);
  return var4;
}

function blockade_barrier_clip(var0) {
  self.old_weapon = self.weapon;
  self.canseecantshoottime = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  self giveweapon(self.canseecantshoottime);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.canseecantshoottime);
  self.ascender = spawn("script_model", var0.origin);
  self.ascender.angles = var0.angles;
  self.ascender setModel("misc_wm_ascender");
  self.ascender hide();
}

function blockade_gate() {
  self giveweapon(self.old_weapon);
  self takeweapon(self.canseecantshoottime);
  self setspawnweapon(self.old_weapon);
}

function bloadinghvt(var0) {
  var1 = scripts\engine\utility::getStructArray("ascend_begin", "script_noteworthy");
  var2 = scripts\engine\utility::getclosest(var0, var1);
  return var2;
}

function blockachievementstimestamp(var0) {
  var1 = scripts\engine\utility::getStructArray("descend_begin", "script_noteworthy");
  var2 = scripts\engine\utility::getclosest(var0, var1);
  return var2;
}

function canplaycircleopendialog() {
  self endon("ascended");
  var0 = self.ascender;
  self.do_immediate_ragdoll = 1;
  self waittill("death");
  var0 delete();
}

function ref_13baa(var0, var1) {
  if(var0) {
    self.ignoreall = 1;

    if(isDefined(var1)) {
      self.goalradius = 8;
      self setgoalpos(self getclosestreachablepointonnavmesh(var1.origin));
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