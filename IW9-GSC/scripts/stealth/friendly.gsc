/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\friendly.gsc
***********************************************/

main() {
  if(!isDefined(level.stealth))
    scripts\stealth\manager::main();

  init_settings();
  self._id_D7F4A1B60F84E53F = self.script_stealthgroup;
  thread spotted_thread();
  thread visibility_thread();
  self _meth_95D5375059C2A022("mp_stealth");
}

init_settings() {
  self.stealth = spawnStruct();
  self.stealth.funcs = [];
  scripts\engine\utility::ent_flag_init("stealth_enabled");
  scripts\engine\utility::ent_flag_set("stealth_enabled");
  scripts\engine\utility::ent_flag_init("stealth_in_shadow");
  scripts\stealth\utility::group_flag_init("stealth_spotted");
  scripts\stealth\utility::group_add();
  self._id_FE5EBEFA740C7106 = 0;
}

spotted_thread() {
  self endon("death");
  self notify("spotted_thread");
  self endon("spotted_thread");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");
    scripts\stealth\utility::group_flag_waitopen("stealth_spotted");

    if(!scripts\engine\utility::ent_flag("stealth_enabled"))
      scripts\engine\utility::ent_flag_wait("stealth_enabled");

    thread state_hidden();
    scripts\engine\utility::ent_flag_wait("stealth_enabled");
    scripts\stealth\utility::group_flag_wait("stealth_spotted");

    if(!scripts\engine\utility::ent_flag("stealth_enabled"))
      scripts\engine\utility::ent_flag_wait("stealth_enabled");

    thread state_spotted();
  }
}

state_hidden() {
  thread scripts\stealth\utility::setbattlechatter(0);
  self.stealth.oldgrenadeammo = self.grenadeammo;
  self.grenadeammo = 0;
  self.forcesidearm = 0;
  self.dontevershoot = 1;
  self.dontattackme = 1;

  if(isDefined(self.stealth.funcs["hidden"]))
    scripts\stealth\callbacks::stealth_call_thread("hidden");
}

state_spotted() {
  thread scripts\stealth\utility::setbattlechatter(1);

  if(isDefined(self.stealth.oldgrenadeammo))
    self.grenadeammo = self.stealth.oldgrenadeammo;
  else
    self.grenadeammo = 3;

  self.dontevershoot = 0;
  self.dontattackme = 0;
  self pushplayer(0);

  if(isDefined(self.stealth.funcs["spotted"]))
    scripts\stealth\callbacks::stealth_call_thread("spotted");
}

getup_from_prone() {
  self endon("death");
}

visibility_thread() {
  self endon("death");
  self endon("long_death");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("stealth_enabled");

    if(!isDefined(self.stealth.ignore_visibility))
      self.maxvisibledist = get_detect_range();

    wait 0.05;
  }
}

get_detect_range() {
  stance = self.currentpose;

  if(stance == "back")
    stance = "prone";

  if(scripts\stealth\utility::group_spotted_flag())
    detection = "spotted";
  else
    detection = "hidden";

  range = _func_10CF685DA2BFFEDA(detection, stance);

  if(scripts\engine\utility::ent_flag("stealth_in_shadow"))
    range = max(_func_10CF685DA2BFFEDA("hidden", "prone"), range * 0.5);

  return range;
}