/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\neutral.gsc
***********************************************/

main() {
  if(isDefined(self.stealth)) {
    return;
  }
  scripts\stealth\enemy::init_settings();
  self.neutralsenses = 1;
  scripts\stealth\enemy::init_flags();
  scripts\stealth\group::addtogroup(self.script_stealthgroup, self);
  scripts\stealth\enemy::setpatrolstyle_base();
  scripts\stealth\event::event_init_entity();
  thread scripts\stealth\enemy::monitor_damage_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
  scripts\stealth\enemy::set_alert_level("_encstr_88F20627959BCAE8");
  scripts\stealth\enemy::bt_set_stealth_state("_encstr_A7C5056BD931D1");
  scripts\stealth\enemy::stealth_init_goal_radius();
}