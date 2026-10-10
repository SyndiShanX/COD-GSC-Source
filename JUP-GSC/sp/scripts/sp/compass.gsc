/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\compass.gsc
***********************************************/

#namespace compass;

function setupminimap(material, corner_targetname, var_3b70dd7d0d5b9a8) {
  if(!isDefined(material)) {
    material = "";
  }

  level.minimap_image = material;

  if(!isDefined(corner_targetname)) {
    corner_targetname = "minimap_corner";
  }

  requiredmapaspectratio = getdvarfloat(@ "scr_requiredmapaspectratio", 1);
  corners = getEntArray(corner_targetname, "targetname");

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
    var_9f72e62e262287df = vectordot(northwest - southeast, north);
    var_755d4c721ecb6165 = vectordot(northwest - southeast, west);
    mapaspectratio = var_755d4c721ecb6165 / var_9f72e62e262287df;

    if(mapaspectratio < requiredmapaspectratio) {
      incr = requiredmapaspectratio / mapaspectratio;
      addvec = vecscale(west, var_755d4c721ecb6165 * (incr - 1) * 0.5);
    } else {
      incr = mapaspectratio / requiredmapaspectratio;
      addvec = vecscale(north, var_9f72e62e262287df * (incr - 1) * 0.5);
    }

    northwest += addvec;
    southeast -= addvec;
  }

  level.map_extents = [];
  level.map_extents["top"] = northwest[1];
  level.map_extents["left"] = southeast[0];
  level.map_extents["bottom"] = southeast[1];
  level.map_extents["right"] = northwest[0];
  level.map_width = level.map_extents["right"] - level.map_extents["left"];
  level.map_height = level.map_extents["top"] - level.map_extents["bottom"];
  level.mapsize = vectordot(northwest - southeast, north);

  if(!isDefined(var_3b70dd7d0d5b9a8) || var_3b70dd7d0d5b9a8 < 1) {
    var_3b70dd7d0d5b9a8 = 1;
  }

  setminimap(material, northwest[0], northwest[1], southeast[0], southeast[1], var_3b70dd7d0d5b9a8);
}

function vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}