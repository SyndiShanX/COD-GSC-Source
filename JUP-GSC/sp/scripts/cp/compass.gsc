/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\compass.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace compass;

function setupminimap(material, numtiles, uselocale) {
  if(!isDefined(material)) {
    material = "";
  }

  requiredmapaspectratio = getdvarfloat(@ "scr_requiredmapaspectratio", 1);
  corners = [];
  allcorners = getEntArray("minimap_corner", "targetname");

  if(!isDefined(uselocale)) {
    uselocale = 0;
  }

  corners = getcornersfromarray(allcorners, uselocale);

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

  corners[0].origin = northwest;
  corners[1].origin = southeast;
  level.mapsize = vectordot(northwest - southeast, north);
  level.mapcorners = corners;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45);

  if(!isDefined(numtiles) || numtiles < 1) {
    numtiles = 1;
  }

  setminimap(material, northwest[0], northwest[1], southeast[0], southeast[1], numtiles);
}

function vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

function getcornersfromarray(array, uselocale) {
  corners = [];

  if(uselocale) {
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