/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\neutral.gsc
***************************************/

#using scripts\stealth\debug;
#using scripts\stealth\enemy;
#using scripts\stealth\event;
#using scripts\stealth\group;
#namespace neutral;

function main() {
  if(isDefined(self.stealth)) {
    return;
  }

  enemy::init_settings();
  self.neutralsenses = 1;
  self.stealth_groupname = self.script_stealthgroup;
  enemy::init_flags();
  group::addtogroup(self.script_stealthgroup, self);
  self setpatrolstylebase();
  event::event_init_entity();
  thread enemy::monitor_damage_thread();

  thread debug::debug_enemy();

  self function_a207af2267b47c4b("\xbd\xc3\x19\x1f\x83^\xa0\xba\x18");
  enemy::bt_set_stealth_state("\x91\x88\xc2*");
  enemy::stealth_init_goal_radius();
}