/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\little_bird_mg_mp.gsc
***********************************************/

blockade_gate_explode_sequence(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  bomb_sites_spawn(var_1);
  var_2 = "_encstr_A9240A1B4B591DA8DBC9F33F" + var_0 + "_encstr_A71A0491FAF5";
  var_3 = "_encstr_A9240A1B4B591DA8DBC9F33F" + var_0 + "_encstr_A3850616E56F783F";
  var_4 = "_encstr_A9240A1B4B591DA8DBC9F33F" + var_0 + "_encstr_B643052F60A5B0";
  var_5 = "_encstr_96C31083984FB72F0E6FABB3757023FF7D71" + var_0 + "_encstr_9A6F11CF3C215B515F08817AF89F17FBB9956A";
  var_6 = "_encstr_96C31083984FB72F0E6FABB3757023FF7D71" + var_0 + "_encstr_ABD60FD971C82F918E035FFE874BA10DCD";
  var_7 = "_encstr_96C31083984FB72F0E6FABB3757023FF7D71" + var_0 + "_encstr_956E122F0FC2AD61CF3F615EE6BBC86D0A6BC3FD";
  thread _id_12B4E(var_1);
  var_8 = blockade_barbwires(var_2, var_1);
  var_8.mp_backlot2_patch = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  _id_13BAA(1, var_8);
  thread blinking_light_thread(var_2, var_4, var_3, var_5, var_7, var_6, var_8, var_1, var_0);
  var_1.inuse = 0;
  scripts\engine\utility::_id_143A5("_encstr_8A1F090B9B36AC7332B223", "_encstr_AD75063D571AE108");
}

bomb_sites_spawn(var_0) {
  self.ignoreall = 1;
  self.goalradius = 96;
  self setgoalpos(self getclosestreachablepointonnavmesh(var_0.origin));

  while(istrue(var_0.inuse))
    wait 0.1;

  var_0.inuse = 1;
}

_id_12B4E(var_0) {
  self endon("_encstr_8A1F090B9B36AC7332B223");
  self waittill("_encstr_AD75063D571AE108");
  var_0.inuse = 0;
}

blinking_light_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("_encstr_AD75063D571AE108");
  var_9 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_A6F70EB2E633421759FA701F5BF14557", var_0);
  var_10 = scripts\asm\asm::asm_getxanim("_encstr_A6F70EB2E633421759FA701F5BF14557", var_9);
  var_11 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_A6F70EB2E633421759FA701F5BF14557", var_1);
  var_12 = scripts\asm\asm::asm_getxanim("_encstr_A6F70EB2E633421759FA701F5BF14557", var_11);
  var_13 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_A6F70EB2E633421759FA701F5BF14557", var_2);
  var_14 = scripts\asm\asm::asm_getxanim("_encstr_A6F70EB2E633421759FA701F5BF14557", var_13);
  self setplayerangles(var_6.angles);

  if(var_8 == "_encstr_87070365F7")
    self forceteleport(var_6.origin + anglestoleft(var_6.angles) * -4 + anglesToForward(var_6.angles) * 10, var_6.angles);
  else
    self forceteleport(var_6.origin + anglestoleft(var_6.angles) * 4, var_6.angles);

  blockade_barrier_clip(var_7);
  thread canplaycircleopendialog();
  blink_train_test(var_3, var_7, var_9, var_6, var_10);
  blink_wheelson_chosen_spawn(var_14, var_6);
  blinkblackoverlay(var_4, var_11, var_12);
  blockade_gate();
  _id_13BAA(0);
  self notify("_encstr_8A1F090B9B36AC7332B223");
}

blink_train_test(var_0, var_1, var_2, var_3, var_4) {
  self.ascender scriptmodelplayanimdeltamotionfrompos(var_0, var_1.origin, var_1.angles);
  self animmode("_encstr_B69807B9DE36C69683");
  self aisetanim("_encstr_A6F70EB2E633421759FA701F5BF14557", var_2);
  self orientmode("_encstr_A34A0B518A172592D6E64FA115", var_3.angles[1]);
  waitframe();
  self.ascender show();
  wait(getanimlength(var_4));
}

blink_wheelson_chosen_spawn(var_0, var_1) {
  self.anchor = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  self.anchor.angles = self.angles;
  self linkTo(self.anchor);
  self.ascender linkTo(self.anchor);
  var_2 = getanimlength(var_0);
  self.anchor moveTo(var_1.mp_backlot2_patch.origin, var_2 * 3);
  self.anchor waittill("_encstr_9B420907FD535DAC6DF285");
}

blinkblackoverlay(var_0, var_1, var_2) {
  self unlink();
  self.ascender scriptmodelclearanim();
  self.ascender scriptmodelplayanimdeltamotionfrompos(var_0, self.ascender.origin, self.ascender.angles);
  self aisetanim("_encstr_A6F70EB2E633421759FA701F5BF14557", var_1);
  wait(getanimlength(var_2));
  self.anchor delete();
  self.ascender delete();
}

blockade_barbwires(var_0, var_1) {
  var_2 = scripts\asm\asm::asm_lookupanimfromalias("_encstr_A6F70EB2E633421759FA701F5BF14557", var_0);
  var_3 = scripts\asm\asm::asm_getxanim("_encstr_A6F70EB2E633421759FA701F5BF14557", var_2);
  var_4 = spawnStruct();

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  var_4.origin = getstartorigin(var_1.origin, var_1.angles, var_3);
  var_4.angles = getstartangles(var_1.origin, var_1.angles, var_3);
  return var_4;
}

blockade_barrier_clip(var_0) {
  self.old_weapon = self.weapon;
  self.canseecantshoottime = scripts\cp\cp_weapon::buildweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  self giveweapon(self.canseecantshoottime);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.canseecantshoottime);
  self.ascender = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  self.ascender.angles = var_0.angles;
  self.ascender setModel("_encstr_961D11B9543BCFEE774F09E02FBB611DF2FFAE");
  self.ascender hide();
}

blockade_gate() {
  self giveweapon(self.old_weapon);
  self takeweapon(self.canseecantshoottime);
  self setspawnweapon(self.old_weapon);
}

bloadinghvt(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_85D00DBFA05125A281E0CE07D4A39A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = scripts\engine\utility::getclosest(var_0, var_1);
  return var_2;
}

blockachievementstimestamp(var_0) {
  var_1 = scripts\engine\utility::getStructArray("_encstr_AC250E51FD4A883D33C296393AFFE338", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = scripts\engine\utility::getclosest(var_0, var_1);
  return var_2;
}

canplaycircleopendialog() {
  self endon("_encstr_8A1F090B9B36AC7332B223");
  var_0 = self.ascender;
  self.do_immediate_ragdoll = 1;
  self waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}

_id_13BAA(var_0, var_1) {
  if(var_0) {
    self.ignoreall = 1;

    if(isDefined(var_1)) {
      self.goalradius = 8;
      self setgoalpos(self getclosestreachablepointonnavmesh(var_1.origin));
      self waittill("_encstr_8B7205D9ED5958");
      wait 1;
    }

    scripts\asm\asm_mp::carepackage_get_dropped_entities();
    self.playing_skit = 1;
  } else {
    self.goalradius = 4096;
    self.ignoreall = 0;
    scripts\asm\shared\mp\utility::bunkercounteruav();
    self.playing_skit = undefined;
  }
}