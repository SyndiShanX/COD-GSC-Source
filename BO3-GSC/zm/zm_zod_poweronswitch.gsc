/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_poweronswitch.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;

class cpoweronswitch {
  var m_t_switch;
  var m_arg1;
  var m_func;
  var m_n_power_index;
  var m_mdl_switch;

  constructor() {}

  destructor() {}

  function local_power_on() {
    m_t_switch sethintstring(&"ZM_ZOD_POWERSWITCH_POWERED");
    do {
      m_t_switch waittill("trigger", player);
    }
    while(!can_player_use(player));
    m_t_switch setinvisibletoall();
    [[m_func]](m_arg1);
  }

  function can_player_use(player) {
    if(player zm_utility::in_revive_trigger()) {
      return false;
    }
    if(player.is_drinking > 0) {
      return false;
    }
    return true;
  }

  function show_activated_state() {
    m_t_switch setinvisibletoall();
  }

  function poweronswitch_think() {
    level flag::wait_till("power_on" + m_n_power_index);
    local_power_on();
  }

  function filter_areaname(e_entity, str_areaname) {
    if(!isDefined(e_entity.script_string) || e_entity.script_string != str_areaname) {
      return false;
    }
    return true;
  }

  function init_poweronswitch(str_areaname, script_int, linkto_target, func, arg1, n_iter = 0) {
    a_mdl_switch = getEntArray("stair_control", "targetname");
    a_mdl_switch = array::filter(a_mdl_switch, 0, & filter_areaname, str_areaname);
    m_mdl_switch = a_mdl_switch[n_iter];
    a_t_switch = getEntArray("stair_control_usetrigger", "targetname");
    a_t_switch = array::filter(a_t_switch, 0, & filter_areaname, str_areaname);
    m_t_switch = a_t_switch[n_iter];
    m_t_switch sethintstring(&"ZM_ZOD_POWERSWITCH_UNPOWERED");
    m_n_power_index = script_int;
    m_func = func;
    m_arg1 = arg1;
    m_t_switch enablelinkto();
    m_t_switch linkto(m_mdl_switch);
    if(isDefined(linkto_target)) {
      m_mdl_switch linkto(linkto_target);
    }
    self thread poweronswitch_think();
  }

}