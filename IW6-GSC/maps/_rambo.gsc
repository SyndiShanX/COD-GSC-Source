/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_rambo.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  if(isDefined(anim.ramboanims)) {
    return;
  }
  if(!isDefined(level.subclass_spawn_functions)) {
    level.subclass_spawn_functions = [];
  }

  level.subclass_spawn_functions["militia"] = ::enable_militia_behavior;
  anim.ramboanims = spawnStruct();
  anim.ramboanims.coverleft90 = animscripts\utility::array( % favela_chaotic_cornerl_hop90, % favela_chaotic_cornerl_high90, % favela_chaotic_cornerl_mid90);
  anim.ramboanims.coverleft45 = animscripts\utility::array( % favela_chaotic_cornerl_high45, % favela_chaotic_cornerl_mid45);
  anim.ramboanims.coverleftgrenade = % favela_chaotic_cornerl_grenade;
  anim.ramboanims.coverright90 = animscripts\utility::array( % favela_chaotic_cornerr_med90, % favela_chaotic_cornerr_low90, % favela_chaotic_cornerr_high90);
  anim.ramboanims.coverright45 = animscripts\utility::array( % favela_chaotic_cornerr_med45, % favela_chaotic_cornerr_low45, % favela_chaotic_cornerr_high45);
  anim.ramboanims.coverrightgrenade = % favela_chaotic_cornerr_grenade;
  anim.ramboanims.coverstand = animscripts\utility::array( % favela_chaotic_standcover_firea, % favela_chaotic_standcover_fireb, % favela_chaotic_standcover_firec);
  anim.ramboanims.coverstandfail = animscripts\utility::array( % favela_chaotic_standcover_gunjama, % favela_chaotic_standcover_gunjamb);
  anim.ramboanims.coverstandgrenade = animscripts\utility::array( % favela_chaotic_standcover_grenadefirea);
  anim.ramboanims.covercrouch = animscripts\utility::array( % favela_chaotic_crouchcover_firea, % favela_chaotic_crouchcover_fireb, % favela_chaotic_crouchcover_firec);
  anim.ramboanims.covercrouchfail = animscripts\utility::array( % favela_chaotic_crouchcover_gunjama, % favela_chaotic_crouchcover_gunjamb);
  anim.ramboanims.covercrouchgrenade = animscripts\utility::array( % favela_chaotic_crouchcover_grenadefirea);
  setrambogrenadeoffsets();
}

setrambogrenadeoffsets() {
  animscripts\combat_utility::addgrenadethrowanimoffset( % favela_chaotic_cornerr_grenade, (52.4535, 10.107, 64.2898));
  animscripts\combat_utility::addgrenadethrowanimoffset( % favela_chaotic_cornerl_grenade, (19.1753, -18.9954, 49.3355));
  animscripts\combat_utility::addgrenadethrowanimoffset( % favela_chaotic_standcover_grenadefirea, (6.66898, -0.135193, 72.117));
  animscripts\combat_utility::addgrenadethrowanimoffset( % favela_chaotic_crouchcover_grenadefirea, (4.53614, -10.4574, 59.7186));
}

enable_militia_behavior() {
  if(self.type == "dog") {
    return;
  }
  self.neverenablecqb = 1;
  self.maxfaceenemydist = 256;

  if(animscripts\combat_utility::islongrangeai()) {
    return;
  }
  if(animscripts\utility::isshotgun(self.weapon)) {
    return;
  }
  self.disable_blindfire = undefined;
  self.favor_blindfire = 1;
  self.rambochance = 0.9;
  self.ramboaccuracymult = 1.0;
  self.baseaccuracy = 0.75;
  self.neversprintforvariation = undefined;
}

disable_militia_behavior() {
  self.favor_blindfire = undefined;
  self.rambochance = undefined;
  self.neverenablecqb = 0;
  self.maxfaceenemydist = 512;
  self.ramboaccuracymult = undefined;
}