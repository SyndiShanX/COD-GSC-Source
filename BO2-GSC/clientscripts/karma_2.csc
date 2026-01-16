/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\karma_2.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_glasses;
#include clientscripts\karma_utility;
#include clientscripts\karma_2_fx;
#include clientscripts\_load;
#include clientscripts\_swimming;
#include clientscripts\_audio;
#include clientscripts\karma_2_amb;

main() {
  clientscripts\karma_2_fx::main();
  clientscripts\_load::main();
  clientscripts\_swimming::main();
  level thread clientscripts\_audio::audio_init(0);
  level thread clientscripts\karma_2_amb::main();
  register_clientflag_callback("scriptmover", 12, ::glow_metal);
  register_clientflag_callback("scriptmover", 15, ::float_body);
  waitforclient(0);

  println("*** Client : karma_2 running...");

  level thread fov_listener("fov_zoom", 10);
  level thread fov_listener("fov_zoom_hi", 3);
  level thread fov_listener("fov_normal", 70);
}

face_swap(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  self mapshaderconstant(localclientnum, 1, "ScriptVector1");
  layera_transparency = 0.0;
  layerb_transparency = 0.0;

  if(set) {
    layerc_transparency = 1.0;
    layerd_transparency = 0.0;
  } else {
    layerc_transparency = 0.0;
    layerd_transparency = 1.0;
  }

  layere_transparency = 0.0;
  layerf_transparency = 0.0;
  self setshaderconstant(localclientnum, 0, layera_transparency, layerb_transparency, layerc_transparency, layerd_transparency);
  self setshaderconstant(localclientnum, 1, layere_transparency, layerf_transparency, 0, 0);
}

glow_metal(localclientnum, set, newent) {
  if(set)
    lerp_shader_constant(localclientnum, 0, "ScriptVector0", 1, 0.01, 1);
  else
    lerp_shader_constant(localclientnum, 0, "ScriptVector0", 1, 0.01, 0);
}

float_body(localclientnum, set, newent) {
  self endon("entityshutdown");

  if(set) {
    e_fx = spawn(localclientnum, get_floating_body_fx_origin(), "script_model");
    e_fx setmodel("tag_origin");
    e_fx.angles = vectorscale((-1, 0, 0), 90.0);
    playfxontag(localclientnum, level._effect["blood_cloud_water"], e_fx, "tag_origin");

    while(isDefined(self)) {
      e_fx.origin = get_floating_body_fx_origin();
      wait 0.1;
    }
  }
}

get_floating_body_fx_origin() {
  n_water_height = getwaterheight(self.origin);
  v_origin = (self.origin[0], self.origin[1], n_water_height + 1);
  return v_origin;
}