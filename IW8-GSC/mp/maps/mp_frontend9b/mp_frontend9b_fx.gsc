main() {
  level._effect["vfx_frontend_9b_action_tire_landing"] = LoadFX("vfx/iw8/level/frontend/s9b/vfx_frontend_9b_action_tire_landing.vfx");
  level._effect["vfx_frontend_9b_action_tire_flames"] = LoadFX("vfx/iw8/level/frontend/s9b/vfx_frontend_9b_action_tire_flames.vfx");
  level._effect["vfx_frontend_9b_action_tire_explo"] = LoadFX("vfx/iw8/level/frontend/s9b/vfx_frontend_9b_action_tire_explo.vfx");

  if(getDvar("OKOLRTLORL") != "1") {
    scripts\mp\maps\mp_frontend9b\gen\mp_frontend9b_fx::main();
    scripts\mp\maps\mp_frontend9b\gen\mp_frontend9b_sound::main();
  }
}