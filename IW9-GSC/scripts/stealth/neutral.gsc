/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\neutral.gsc
***********************************************/

main() {
  if(isDefined(self.stealth)) {
    return;
  }
  scripts\stealth\enemy::init_settings();
  self.neutralsenses = 1;
  self._id_D7F4A1B60F84E53F = self.script_stealthgroup;
  scripts\stealth\enemy::init_flags();
  scripts\stealth\group::addtogroup(self.script_stealthgroup, self);
  self _meth_4DB6FC194702D153();
  scripts\stealth\event::event_init_entity();
  thread scripts\stealth\enemy::monitor_damage_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
  self _meth_1AFF80C5FC5A3EEA("noncombat");
  scripts\stealth\enemy::bt_set_stealth_state("idle");
  scripts\stealth\enemy::stealth_init_goal_radius();
}