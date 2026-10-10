/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\vehicle_heavy_destruction.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace vehicle_heavy_destruction;

function init_vehicle_heavy_destruction() {}

function reverse_impact_think() {
  self endon("stop_heavy_damage");
  self setCanDamage(1);
  back_checks = 1;
  var_10307d8953138b5a = 12;
  contents = scripts\engine\trace::create_all_contents();

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon);
    start_point = point;
    end_point = point;

    for(i = 0; i < back_checks; i++) {
      end_point = start_point + direction_vec * 0.5;
      start_point = end_point + direction_vec * var_10307d8953138b5a;
      color = (randomfloat(1), randomfloat(1), randomfloat(1));
      jku_arrow(start_point, end_point, color, 1, 1, 200, direction_vec);
      magicbullet("veh_exit_hack", start_point, end_point);
      waitframe();
    }
  }
}

function jku_arrow(start, end, color, alpha, depthtest, duration, direction_vec) {
  setdvarifuninitialized(@ "hash_c57da70cd16526c7", 0);

  if(getdvarint(@ "hash_c57da70cd16526c7") == 1) {
    if(!isDefined(color)) {
      color = (randomfloat(1), randomfloat(1), randomfloat(1));
    }

    line(start, end, color, alpha, depthtest, duration);
    line(end, end + anglestoright(direction_vec) * -2, color, alpha, depthtest, duration);
  }
}

function jku_point(position, size, color, duration) {
  setdvarifuninitialized(@ "hash_c57da70cd16526c7", 0);

  if(getdvarint(@ "hash_c57da70cd16526c7") == 1) {
    if(!isDefined(position)) {
      assertmsg("<dev string:x1c>");
      return;
    } else {
      point = position;
    }

    if(!isDefined(size)) {
      size = 6;
    }

    if(!isDefined(color)) {
      color = (1, 1, 1);
    }

    if(!isDefined(duration)) {
      duration = 400;
    }

    line(point + (size, 0, 0), point - (size, 0, 0), color, 1, 1, duration);
    line(point + (0, size, 0), point - (0, size, 0), color, 1, 1, duration);
    line(point + (0, 0, size), point - (0, 0, size), color, 1, 1, duration);
  }
}