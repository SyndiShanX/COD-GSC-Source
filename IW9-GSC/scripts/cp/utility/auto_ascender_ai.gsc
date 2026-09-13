/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\auto_ascender_ai.gsc
***************************************************/

ai_ascender_use(dir, _id_E329E466286DFC92) {
  self endon("death");
  ai_goto_ascender_and_wait(_id_E329E466286DFC92);
  _id_0478BFAC22EA8F9E = "ascender_" + dir + "_in";
  _id_16EECE1D377A2B4B = "ascender_" + dir + "_loop";
  _id_A2AA0D90B41A955F = "ascender_" + dir + "_out";
  _id_CFB273D832B1732E = "wm_eq_ascender_" + dir + "_get_on_ascender";
  _id_FFE0BD8231CC883B = "wm_eq_ascender_" + dir + "_loop_ascender";
  _id_5D4EBA776ABDCECF = "wm_eq_ascender_" + dir + "_get_off_ascender";
  thread release_ascendstruct_ondeath(_id_E329E466286DFC92);
  _id_B02A4B4BFC64AA4E = ai_ascender_getstartpos(_id_0478BFAC22EA8F9E, _id_E329E466286DFC92);
  _id_B02A4B4BFC64AA4E.end_node = scripts\engine\utility::getStruct(_id_E329E466286DFC92.target, "targetname");
  toggle_ai_settings(1, _id_B02A4B4BFC64AA4E);
  thread ai_ascender_doanims(_id_0478BFAC22EA8F9E, _id_A2AA0D90B41A955F, _id_16EECE1D377A2B4B, _id_CFB273D832B1732E, _id_5D4EBA776ABDCECF, _id_FFE0BD8231CC883B, _id_B02A4B4BFC64AA4E, _id_E329E466286DFC92, dir);
  _id_E329E466286DFC92.inuse = 0;
  scripts\engine\utility::waittill_any_2("ascended", "death");
}

ai_goto_ascender_and_wait(_id_E329E466286DFC92) {
  self.ignoreall = 1;
  self.goalradius = 96;
  self setgoalpos(self getclosestreachablepointonnavmesh(_id_E329E466286DFC92.origin));

  while(istrue(_id_E329E466286DFC92.inuse))
    wait 0.1;

  _id_E329E466286DFC92.inuse = 1;
}

release_ascendstruct_ondeath(_id_E329E466286DFC92) {
  self endon("ascended");
  self waittill("death");
  _id_E329E466286DFC92.inuse = 0;
}

ai_ascender_doanims(_id_0478BFAC22EA8F9E, _id_A2AA0D90B41A955F, _id_16EECE1D377A2B4B, _id_CFB273D832B1732E, _id_5D4EBA776ABDCECF, _id_FFE0BD8231CC883B, _id_B02A4B4BFC64AA4E, animnode, dir) {
  self endon("death");
  _id_D242FEFC078B21D9 = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", _id_0478BFAC22EA8F9E);
  _id_244B47A473BC2CF8 = scripts\asm\asm::asm_getxanim("animscripted2", _id_D242FEFC078B21D9);
  _id_BC638C476608C29E = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", _id_A2AA0D90B41A955F);
  _id_ABDCC31F53AAEB21 = scripts\asm\asm::asm_getxanim("animscripted2", _id_BC638C476608C29E);
  _id_9AC8D3C06231F652 = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", _id_16EECE1D377A2B4B);
  _id_FD4A95F23EBCC23D = scripts\asm\asm::asm_getxanim("animscripted2", _id_9AC8D3C06231F652);
  self setplayerangles(_id_B02A4B4BFC64AA4E.angles);

  if(dir == "up")
    self forceteleport(_id_B02A4B4BFC64AA4E.origin + anglestoleft(_id_B02A4B4BFC64AA4E.angles) * -4 + anglesToForward(_id_B02A4B4BFC64AA4E.angles) * 10, _id_B02A4B4BFC64AA4E.angles);
  else
    self forceteleport(_id_B02A4B4BFC64AA4E.origin + anglestoleft(_id_B02A4B4BFC64AA4E.angles) * 4, _id_B02A4B4BFC64AA4E.angles);

  ai_ascender_giveascender(animnode);
  thread ascender_deathwatcher();
  ai_ascender_animin(_id_CFB273D832B1732E, animnode, _id_D242FEFC078B21D9, _id_B02A4B4BFC64AA4E, _id_244B47A473BC2CF8);
  ai_ascender_animloop(_id_FD4A95F23EBCC23D, _id_B02A4B4BFC64AA4E);
  ai_ascender_animout(_id_5D4EBA776ABDCECF, _id_BC638C476608C29E, _id_ABDCC31F53AAEB21);
  ai_ascender_takeascender();
  toggle_ai_settings(0);
  self notify("ascended");
}

ai_ascender_animin(_id_CFB273D832B1732E, struct, _id_D242FEFC078B21D9, animnode, _id_244B47A473BC2CF8) {
  self.ascender scriptmodelplayanimdeltamotionfrompos(_id_CFB273D832B1732E, struct.origin, struct.angles);
  self animmode("noclip");
  self aisetanim("animscripted2", _id_D242FEFC078B21D9);
  self orientmode("face angle", animnode.angles[1]);
  waitframe();
  self.ascender show();
  wait(getanimlength(_id_244B47A473BC2CF8));
}

ai_ascender_animloop(_id_FD4A95F23EBCC23D, animnode) {
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkTo(self.anchor);
  self.ascender linkTo(self.anchor);
  _id_675510F88D731497 = getanimlength(_id_FD4A95F23EBCC23D);
  self.anchor moveTo(animnode.end_node.origin, _id_675510F88D731497 * 3);
  self.anchor waittill("movedone");
}

ai_ascender_animout(_id_5D4EBA776ABDCECF, _id_BC638C476608C29E, _id_ABDCC31F53AAEB21) {
  self unlink();
  self.ascender scriptmodelclearanim();
  self.ascender scriptmodelplayanimdeltamotionfrompos(_id_5D4EBA776ABDCECF, self.ascender.origin, self.ascender.angles);
  self aisetanim("animscripted2", _id_BC638C476608C29E);
  wait(getanimlength(_id_ABDCC31F53AAEB21));
  self.anchor delete();
  self.ascender delete();
}

ai_ascender_getstartpos(animalias, animnode) {
  _id_B94D3FF91445983F = scripts\asm\asm::asm_lookupanimfromalias("animscripted2", animalias);
  xanim = scripts\asm\asm::asm_getxanim("animscripted2", _id_B94D3FF91445983F);
  start_node = spawnStruct();

  if(!isDefined(animnode.angles))
    animnode.angles = (0, 0, 0);

  start_node.origin = getstartorigin(animnode.origin, animnode.angles, xanim);
  start_node.angles = getstartangles(animnode.origin, animnode.angles, xanim);
  return start_node;
}

ai_ascender_giveascender(struct) {
  self.old_weapon = self.weapon;
  self.ascender_weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
  self giveweapon(self.ascender_weapon);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.ascender_weapon);
  self.ascender = spawn("script_model", struct.origin);
  self.ascender.angles = struct.angles;
  self.ascender setModel("misc_wm_ascender");
  self.ascender hide();
}

ai_ascender_takeascender() {
  self giveweapon(self.old_weapon);
  self takeweapon(self.ascender_weapon);
  self setspawnweapon(self.old_weapon);
}

ai_ascender_getclosestascender(pos) {
  ascenders = scripts\engine\utility::getStructArray("ascend_begin", "script_noteworthy");
  _id_DFDD438871090D04 = scripts\engine\utility::getclosest(pos, ascenders);
  return _id_DFDD438871090D04;
}

ai_ascender_getclosestdescender(pos) {
  ascenders = scripts\engine\utility::getStructArray("descend_begin", "script_noteworthy");
  _id_DFDD438871090D04 = scripts\engine\utility::getclosest(pos, ascenders);
  return _id_DFDD438871090D04;
}

ascender_deathwatcher() {
  self endon("ascended");
  ascender = self.ascender;
  self.do_immediate_ragdoll = 1;
  self waittill("death");
  ascender delete();
}

toggle_ai_settings(usingascender, goalnode) {
  if(usingascender) {
    self.ignoreall = 1;

    if(isDefined(goalnode)) {
      self.goalradius = 8;
      self setgoalpos(self getclosestreachablepointonnavmesh(goalnode.origin));
      self waittill("goal");
      wait 1;
    }

    scripts\asm\asm_mp::asm_setanimScripted();
    self.playing_skit = 1;
  } else {
    self.goalradius = 4096;
    self.ignoreall = 0;
    scripts\asm\shared\mp\utility::animscripted_clear();
    self.playing_skit = undefined;
  }
}