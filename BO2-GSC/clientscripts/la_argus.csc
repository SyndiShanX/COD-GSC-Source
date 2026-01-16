/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\la_argus.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_argus;

register_argus_zone(str_zone, func_handler) {
  if(!isDefined(level.argus_zones))
    level.argus_zones = [];

  level.argus_zones["argus_zone:" + str_zone] = func_handler;
}

on_argus_notify_off(n_client, n_argus_id, str_user_tag, str_message) {
  return false;
}

on_argus_notify_intro(n_client, n_argus_id, str_user_tag, str_message) {
  switch (str_message) {
    case "buildui":
      return argus_build_ui(n_client, str_user_tag);
    case "create":
      switch (str_user_tag) {
        case "harper":
        case "hillary":
        case "jones":
        case "sam":
          argussetoffset(n_argus_id, vectorscale((0, 0, 1), 30.0));
      }

      break;
    case "in":
      break;
    case "active":
      break;
    case "out":
      break;
  }

  return 1;
}

on_argus_notify_default(n_client, n_argus_id, str_user_tag, str_message) {
  switch (str_message) {
    case "buildui":
      return argus_build_ui(n_client, str_user_tag);
    case "create":
      switch (str_user_tag) {
        case "harper":
        case "hillary":
        case "jones":
        case "sam":
          argussetoffset(n_argus_id, vectorscale((0, 0, 1), 60.0));
      }

      break;
    case "in":
      switch (str_user_tag) {
        case "harper":
        case "hillary":
        case "jones":
        case "sam":
          if(!within_fov(level.localplayers[n_client] geteye(), level.localplayers[n_client] getplayerangles(), argusgetorigin(n_argus_id), 0.99))
            return 0;
      }

      break;
    case "active":
    case "harper":
    case "hillary":
    case "jones":
    case "sam":
      if(!within_fov(level.localplayers[n_client] geteye(), level.localplayers[n_client] getplayerangles(), argusgetorigin(n_argus_id), 0.99))
        return 0;

      break;
    case "out":
      break;
  }

  return 1;
}

argus_build_ui(n_client, str_user_tag) {
  switch (str_user_tag) {
    case "harper":
      return argusimageandtext2ui(n_client, "white", & "LA_SHARED_ARGUS_HARPER", & "LA_SHARED_ARGUS_HARPER_INFO");
    case "sam":
      return argusimageandtext2ui(n_client, "white", & "LA_SHARED_ARGUS_SAM", & "LA_SHARED_ARGUS_SAM_INFO");
    case "hillary":
      return argusimageandtext2ui(n_client, "white", & "LA_SHARED_ARGUS_POTUS", & "LA_SHARED_ARGUS_POTUS_INFO");
    case "jones":
      return argusimageandtext2ui(n_client, "white", & "LA_SHARED_ARGUS_JONES", & "LA_SHARED_ARGUS_JONES_INFO");
  }
}