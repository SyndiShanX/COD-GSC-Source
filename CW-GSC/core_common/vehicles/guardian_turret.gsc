/****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\guardian_turret.gsc
****************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\microwave_turret_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\auto_turret;
#namespace guardian_turret;

function private autoexec __init__system__() {
  system::register(#"guardian_turret", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  vehicle::add_main_callback("microwave_turret", &function_5dfbc20a);
}

function function_5dfbc20a() {
  auto_turret::function_f17009ff();
  guardian_init();
  function_4dc5ff34();
}

function function_4dc5ff34() {
  guardian = self;
  guardian vehicle_ai::get_state_callbacks("combat").update_func = &function_21304ee6;
  guardian vehicle_ai::get_state_callbacks("combat").exit_func = &function_4ea89e5a;
  guardian vehicle_ai::get_state_callbacks("unaware").enter_func = &function_ab51fb9e;
  guardian vehicle_ai::set_state("unaware");
}

function function_ab51fb9e(params) {
  guardian = self;
  guardian clientfield::set("turret_microwave_open", 0);
}

function function_21304ee6(params) {
  guardian = self;
  guardian endon(#"death", #"change_state");

  if(isDefined(guardian.enemy)) {
    auto_turret::sentry_turret_alert_sound();
    wait 0.5;
  }

  guardian startmicrowave();

  while(true) {
    guardian.turretrotscale = 1;

    if(isDefined(guardian.enemy) && isalive(guardian.enemy) && guardian cansee(guardian.enemy)) {
      guardian turretsettarget(0, guardian.enemy);
    }

    guardian vehicle_ai::evaluate_connections();
    wait 0.5;
  }
}

function function_4ea89e5a(params) {
  guardian = self;
  guardian stopmicrowave();
}

function startmicrowave() {
  guardian = self;
  guardian clientfield::set("turret_microwave_open", 1);
  guardian microwave_turret::startmicrowave();
}

function stopmicrowave() {
  guardian = self;

  if(isDefined(guardian)) {
    guardian clientfield::set("turret_microwave_open", 0);
  }
}

function function_e341abb9(totalfiretime, enemy) {
  guardian = self;
  guardian endon(#"death", #"change_state");
  auto_turret::sentry_turret_alert_sound();
  wait 0.1;
  weapon = guardian seatgetweapon(0);
  firetime = weapon.firetime;
  time = 0;

  while(time < enemy) {
    wait firetime;
    time += firetime;
  }
}

function guardian_init() {
  guardian = self;
  guardian.maxsightdistsqrd = 450 * 450;
  guardian turret::set_on_target_angle(15, 0);
  guardian.soundmod = "hpm";
}