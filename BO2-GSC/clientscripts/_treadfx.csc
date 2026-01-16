/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_treadfx.csc
**************************************/

loadtreadfx(vehicle) {
  treadfx = vehicle.treadfxnamearray;

  if(isDefined(treadfx)) {
    vehicle.treadfx = [];
    fx_surface_names = array("asphalt", "bark", "brick", "carpet", "ceramic", "cloth", "concrete", "cushion", "none", "dirt", "flesh", "foliage", "fruit", "glass", "grass", "gravel", "ice", "metal", "mud", "paintedmetal", "plaster", "rock", "rubber", "sand", "snow", "water", "wood");

    for(i = 0; i < fx_surface_names.size; i++) {
      if(isDefined(treadfx[fx_surface_names[i]]) && treadfx[fx_surface_names[i]] != "") {
        if(!isDefined(level._effect[treadfx[fx_surface_names[i]]]))
          level._effect[treadfx[fx_surface_names[i]]] = loadfx(treadfx[fx_surface_names[i]]);

        vehicle.treadfx[fx_surface_names[i]] = level._effect[treadfx[fx_surface_names[i]]];
      }
    }
  }

  lightfx = vehicle.lightfxnamearray;

  if(lightfx.size > 0)
    self.light_fx = [];

  for(i = 0; i < lightfx.size; i++) {
    if(!isDefined(level._effect[lightfx[i]]))
      level._effect[lightfx[i]] = loadfx(lightfx[i]);

    self.light_fx[self.light_fx.size] = level._effect[lightfx[i]];
  }

  if(isDefined(self.friendlylightfxname) && self.friendlylightfxname != "") {
    if(!isDefined(level._effect[self.friendlylightfxname]))
      level._effect[self.friendlylightfxname] = loadfx(self.friendlylightfxname);

    self.friendly_light_fx = level._effect[self.friendlylightfxname];
  }

  if(isDefined(self.enemylightfxname) && self.enemylightfxname != "") {
    if(!isDefined(level._effect[self.enemylightfxname]))
      level._effect[self.enemylightfxname] = loadfx(self.enemylightfxname);

    self.enemy_light_fx = level._effect[self.enemylightfxname];
  }

  if(vehicle.vehicletype == "boat_soct_player") {
    vehicle.throttlefx = [];

    if(!isDefined(level._effect["water/fx_vwater_soct_wake_accelerate_1"]))
      level._effect["water/fx_vwater_soct_wake_accelerate_1"] = loadfx("water/fx_vwater_soct_wake_accelerate_1");

    vehicle.throttlefx[0] = level._effect["water/fx_vwater_soct_wake_accelerate_1"];

    if(!isDefined(level._effect["water/fx_vwater_soct_wake_accelerate_2"]))
      level._effect["water/fx_vwater_soct_wake_accelerate_2"] = loadfx("water/fx_vwater_soct_wake_accelerate_2");

    vehicle.throttlefx[1] = level._effect["water/fx_vwater_soct_wake_accelerate_2"];

    if(!isDefined(level._effect["water/fx_vwater_soct_wake_accelerate_3"]))
      level._effect["water/fx_vwater_soct_wake_accelerate_3"] = loadfx("water/fx_vwater_soct_wake_accelerate_3");

    vehicle.throttlefx[2] = level._effect["water/fx_vwater_soct_wake_accelerate_3"];

    if(!isDefined(level._effect["water/fx_vwater_soct_churn_0"]))
      level._effect["water/fx_vwater_soct_churn_0"] = loadfx("water/fx_vwater_soct_churn_0");

    vehicle.wakefx[0] = level._effect["water/fx_vwater_soct_churn_0"];
    vehicle.wakefx[1] = level._effect["water/fx_vwater_soct_churn_0"];

    if(!isDefined(level._effect["water/fx_vwater_soct_churn_1"]))
      level._effect["water/fx_vwater_soct_churn_1"] = loadfx("water/fx_vwater_soct_churn_1");

    vehicle.wakefx[2] = level._effect["water/fx_vwater_soct_churn_1"];

    if(!isDefined(level._effect["water/fx_vwater_soct_churn_2"]))
      level._effect["water/fx_vwater_soct_churn_2"] = loadfx("water/fx_vwater_soct_churn_2");

    vehicle.wakefx[3] = level._effect["water/fx_vwater_soct_churn_2"];

    if(!isDefined(level._effect["water/fx_vwater_soct_churn_3"]))
      level._effect["water/fx_vwater_soct_churn_3"] = loadfx("water/fx_vwater_soct_churn_3");

    vehicle.wakefx[4] = level._effect["water/fx_vwater_soct_churn_3"];
  }
}