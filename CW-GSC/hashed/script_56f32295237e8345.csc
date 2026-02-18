/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_56f32295237e8345.csc
***********************************************/

#using script_544e81d6e48b88c0;
#using script_78825cbb1ab9f493;
#using scripts\core_common\callbacks_shared;
#namespace namespace_cf48051e;

function event_handler[gametype_init] main(eventstruct) {
  namespace_17baa64d::init();
  callback::add_callback(#"server_objective", &function_3022f6ba);
}

function function_3022f6ba(eventstruct) {
  if(eventstruct.isnew) {
    camera = undefined;

    switch (eventstruct.name) {
      case # "dom_a":
        camera = "dom_a_cam";
        break;
      case # "dom_b":
        camera = "dom_b_cam";
        break;
      case # "dom_c":
        camera = "dom_c_cam";
        break;
      case # "dom_d":
        camera = "dom_d_cam";
        break;
      case # "dom_e":
        camera = "dom_e_cam";
        break;
      case # "dom_headquarter":
        if(eventstruct.team == # "allies") {
          camera = "dom_allies_hq_cam";
        } else if(eventstruct.team == # "axis") {
          camera = "dom_axis_hq_cam";
        }

        break;
    }

    if(isDefined(camera)) {
      namespace_99c84a33::function_99652b58(camera, eventstruct.id);
    }
  }
}