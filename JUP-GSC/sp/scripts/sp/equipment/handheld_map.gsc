/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\handheld_map.gsc
****************************************************/

#using scripts\sp\equipment\offhands;
#namespace handheld_map;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &function_339da040930b7667);
  thread function_5eee8e4ae8fc69a3();
}

function function_339da040930b7667(grenade, weapon) {
  if(isDefined(grenade)) {
    grenade delete();
  }
}

function function_5eee8e4ae8fc69a3() {
  level.player endon("death");

  if(!isDefined(level.map_extents)) {
    function_cffffc8e6c8d7875();
  }

  while(true) {
    updateplayer();
    wait 0.05;
  }
}

function updateplayer() {
  north = (0, 0, getnorthyaw());
  playerorigin = rotatevector(level.player.origin, north);
  xoffset = playerorigin[1] - level.map_extents["left"];
  yoffset = abs(playerorigin[0] - level.map_extents["top"]);
  setomnvar("ui_map_player_x", xoffset);
  setomnvar("ui_map_player_y", yoffset);
  forward = anglesToForward(level.player.angles);
  var_b5642800228e11c9 = rotatevector(forward, north);
  rot = vectortoyaw(var_b5642800228e11c9);
  setomnvar("ui_map_player_rot", rot);
}

function function_cffffc8e6c8d7875() {
  requiredmapaspectratio = getdvarfloat(@ "scr_requiredmapaspectratio", 1.33333);
  corners = getEntArray("minimap_corner", "targetname");

  if(corners.size != 2) {
    println("<dev string:x1c>");
    return;
  }

  corner0 = (corners[0].origin[0], corners[0].origin[1], 0);
  corner1 = (corners[1].origin[0], corners[1].origin[1], 0);
  cornerdiff = corner1 - corner0;
  north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  west = (0 - north[1], north[0], 0);

  if(vectordot(cornerdiff, west) > 0) {
    if(vectordot(cornerdiff, north) > 0) {
      northwest = corner1;
      southeast = corner0;
    } else {
      side = vecscale(north, vectordot(cornerdiff, north));
      northwest = corner1 - side;
      southeast = corner0 + side;
    }
  } else if(vectordot(cornerdiff, north) > 0) {
    side = vecscale(north, vectordot(cornerdiff, north));
    northwest = corner0 + side;
    southeast = corner1 - side;
  } else {
    northwest = corner0;
    southeast = corner1;
  }

  if(requiredmapaspectratio > 0) {
    northportion = vectordot(northwest - southeast, north);
    westportion = vectordot(northwest - southeast, west);
    mapaspectratio = westportion / northportion;

    if(mapaspectratio < requiredmapaspectratio) {
      incr = requiredmapaspectratio / mapaspectratio;
      addvec = vecscale(west, westportion * (incr - 1) * 0.5);
    } else {
      incr = mapaspectratio / requiredmapaspectratio;
      addvec = vecscale(north, northportion * (incr - 1) * 0.5);
    }

    northwest += addvec;
    southeast -= addvec;
  }

  level.map_extents = [];
  level.map_extents["top"] = northwest[1];
  level.map_extents["left"] = northwest[0];
  level.map_extents["bottom"] = southeast[1];
  level.map_extents["right"] = southeast[0];
  level.map_width = level.map_extents["right"] - level.map_extents["left"];
  level.map_height = level.map_extents["top"] - level.map_extents["bottom"];
  setomnvar("ui_map_width", level.map_width);
  setomnvar("ui_map_height", level.map_height);
  level.mapsize = vectordot(northwest - southeast, north);
}

function vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}