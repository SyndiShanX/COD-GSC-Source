/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_compass.gsc
********************************************************/

setupMiniMap(material) {
  level.minimap_image = material;
  if(!isDefined(level._loadStarted)) {
    println("^1Warning: shouldn't call setupMiniMap until after _load::main()");
  }

  requiredMapAspectRatio = getdvarfloat("scr_requiredMapAspectRatio", 1);

  corners = getEntArray("minimap_corner", "targetname");
  if(corners.size != 2) {
    println("^1Error: There are not exactly two \"minimap_corner\" entities in the map. Could not set up minimap.");
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
  } else {
    if(vectordot(cornerdiff, north) > 0) {
      side = vecscale(north, vectordot(cornerdiff, north));
      northwest = corner0 + side;
      southeast = corner1 - side;
    } else {
      northwest = corner0;
      southeast = corner1;
    }
  }

  if(requiredMapAspectRatio > 0) {
    northportion = vectordot(northwest - southeast, north);
    westportion = vectordot(northwest - southeast, west);
    mapAspectRatio = westportion / northportion;
    if(mapAspectRatio < requiredMapAspectRatio) {
      incr = requiredMapAspectRatio / mapAspectRatio;
      addvec = vecscale(west, westportion * (incr - 1) * 0.5);
    } else {
      incr = mapAspectRatio / requiredMapAspectRatio;
      addvec = vecscale(north, northportion * (incr - 1) * 0.5);
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

  setMiniMap(material, northwest[0], northwest[1], southeast[0], southeast[1]);
}

vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}