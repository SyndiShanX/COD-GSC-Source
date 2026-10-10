/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\compass.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace compass;

function setupminimap(material, var_3b70dd7d0d5b9a8, var_c6f1388c16a82062) {
  if(!isDefined(material)) {
    material = "";
  }

  requiredmapaspectratio = getdvarfloat(@ "scr_requiredmapaspectratio", 1);
  corners = [];
  allcorners = getEntArray("minimap_corner", "targetname");

  if(!isDefined(var_c6f1388c16a82062)) {
    var_c6f1388c16a82062 = 0;
  }

  corners = getcornersfromarray(allcorners, var_c6f1388c16a82062);

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

  corners[0].origin = northwest;
  corners[1].origin = southeast;
  level.mapsize = vectordot(northwest - southeast, north);
  level.mapcorners = corners;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45);

  if(!isDefined(var_3b70dd7d0d5b9a8) || var_3b70dd7d0d5b9a8 < 1) {
    var_3b70dd7d0d5b9a8 = 1;
  }

  setminimap(material, northwest[0], northwest[1], southeast[0], southeast[1], var_3b70dd7d0d5b9a8);
}

function vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

function getcornersfromarray(array, var_c6f1388c16a82062) {
  corners = [];

  if(var_c6f1388c16a82062) {
    foreach(corner in array) {
      if(isDefined(corner.script_noteworthy) && corner.script_noteworthy == level.localeid) {
        corners[corners.size] = corner;
      }
    }
  } else {
    foreach(corner in array) {
      if(!isDefined(corner.script_noteworthy) || isDefined(corner.script_noteworthy) && !issubstr(corner.script_noteworthy, "locale")) {
        corners[corners.size] = corner;
      }
    }
  }

  return corners;
}