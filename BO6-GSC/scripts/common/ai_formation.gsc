/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\ai_formation.gsc
*******************************************/

#using scripts\engine\utility;
#namespace ai_formation;

function init_formations() {
  if(!isDefined(level.formationlist)) {
    level.formationlist = [];
  }
}

function function_5b447ea9cfdca229(formationname, formationtype) {
  if(!isDefined(level.formationlist)) {
    init_formations();
  }

  if(isDefined(level.formationlist[formationname])) {
    return level.formationlist[formationname];
  }

  assert(formationtype >= 0 && formationtype < 4, "<dev string:x24>" + formationtype);
  level.formationlist[formationname] = newaiformation(formationtype);
  return level.formationlist[formationname];
}

function delete_formation(formationname) {
  if(!isDefined(level.formationlist[formationname])) {
    return;
  }

  deleteaiformation(level.formationlist[formationname]);
  level.formationlist[formationname] = undefined;
}

function function_8565456e89e312b0(formationname, aitoadd, formationtype = 3) {
  if(!isDefined(level.formationlist)) {
    init_formations();
  }

  if(!isDefined(level.formationlist[formationname])) {
    function_5b447ea9cfdca229(formationname, formationtype);
  }

  if(!isarray(aitoadd)) {
    aitoadd = [aitoadd];
  }

  foreach(ai in aitoadd) {
    ai enter_formation(level.formationlist[formationname]);
    ai thread need_to_run(formationname);
  }
}

function function_d5b4239f2e53801c(formationname, agents) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  level notify("]xC\xe6~\xc9h,\xc1H[\x11\xb7W\xbf\xefyx0\x1c\x05oH\xb0U\xff\xde\x89\xd0|E\xe92ZvC\x15IFq" + formationname);
  level endon("]xC\xe6~\xc9h,\xc1H[\x11\xb7W\xbf\xefyx0\x1c\x05oH\xb0U\xff\xde\x89\xd0|E\xe92ZvC\x15IFq" + formationname);
  var_7253d31fd0a13fd5 = 1;

  while(istrue(var_7253d31fd0a13fd5)) {
    var_7253d31fd0a13fd5 = 0;

    foreach(agent in level.patrolformations[formationname].members) {
      if(isDefined(agent) && isalive(agent)) {
        var_7253d31fd0a13fd5 = 1;
      }
    }

    wait 2;
  }

  delete_formation(formationname);
  level.patrolformations[formationname] = undefined;
}

function function_73fd5a4d9fca0df9(formationname, horizontalcount, verticalcount, horizontalseparation, verticalseparation, leaderinfront = 0) {
  if(!isDefined(level.formationlist[formationname])) {
    return;
  }

  mid = floor(horizontalcount / 2);
  offsetcount = 1;

  for(verticalindex = 0; verticalindex < verticalcount; verticalindex++) {
    for(horizontalindex = 0; horizontalindex < horizontalcount; horizontalindex++) {
      if(!leaderinfront && verticalindex == 0 && horizontalindex == mid) {
        continue;
      }

      yoffset = horizontalseparation * -1 * (horizontalindex - mid);
      xoffset = verticalseparation * -1 * verticalindex;

      if(leaderinfront) {
        yoffset -= 0.5 * (horizontalcount - 1) % 2 * horizontalseparation;
        xoffset -= verticalseparation;
      }

      function_b87ed92b349a7f11(level.formationlist[formationname], offsetcount, (xoffset, yoffset, 0));
      offsetcount++;
    }
  }
}

function function_4b7f6ccb8ef62b13(formationname, formationshape, numai, horizontalseparation, verticalseparation, leaderinfront = 0) {
  if(!isDefined(level.formationlist[formationname])) {
    return 1;
  }

  if(numai <= 1) {
    return 1;
  }

  if(leaderinfront && formationshape != 1) {
    numai--;
  }

  switch (formationshape) {
    case 1:
      dimension = ceil((sqrt(8 * numai + 1) - 1) / 2);
      offsetcount = 1;

      for(verticalindex = 0; verticalindex < dimension; verticalindex++) {
        for(horizontalindex = 0; horizontalindex < verticalindex + 1; horizontalindex++) {
          if(verticalindex == 0 && horizontalindex == 0) {
            continue;
          }

          yoffset = horizontalseparation * (horizontalindex - verticalindex / 2);
          xoffset = verticalseparation * -1 * verticalindex;
          function_b87ed92b349a7f11(level.formationlist[formationname], offsetcount, (xoffset, yoffset, 0));
          offsetcount++;
        }
      }

      return ((dimension - 1) * horizontalseparation);
    case 2:
      mid = 0;
      horizontalcount = 1;
      verticalcount = numai;
      break;
    case 3:
      mid = 1;
      horizontalcount = 2;
      verticalcount = ceil(numai / horizontalcount);
      break;
    case 4:
      mid = 1;
      horizontalcount = 3;
      verticalcount = ceil(numai / horizontalcount);
      break;
    default:
      horizontalcount = ceil(sqrt(numai));
      verticalcount = ceil(numai / horizontalcount);
      mid = floor(horizontalcount / 2);
      break;
  }

  offsetcount = 1;

  for(verticalindex = 0; verticalindex < verticalcount; verticalindex++) {
    for(horizontalindex = 0; horizontalindex < horizontalcount; horizontalindex++) {
      if(!leaderinfront && verticalindex == 0 && horizontalindex == mid) {
        continue;
      }

      yoffset = horizontalseparation * -1 * (horizontalindex - mid);
      xoffset = verticalseparation * -1 * verticalindex;

      if(leaderinfront) {
        yoffset -= 0.5 * (horizontalcount - 1) % 2 * horizontalseparation;
        xoffset -= verticalseparation;
      }

      function_b87ed92b349a7f11(level.formationlist[formationname], offsetcount, (xoffset, yoffset, 0));
      offsetcount++;
    }
  }

  return (horizontalcount - 1) * horizontalseparation;
}

function function_c8d1dab4b8e9ecf4(formationname, customoffsetlist) {
  if(!isDefined(level.formationlist[formationname])) {
    return;
  }

  assert(customoffsetlist.size < 31, "<dev string:x42>" + utility::string(31) + "<dev string:x73>" + level.formationlist[formationname]);
  count = 1;

  foreach(offset in customoffsetlist) {
    function_b87ed92b349a7f11(level.formationlist[formationname], count, offset);
    count++;
  }
}

function function_d40312f436b7806d(formationname, formationslot, customoffset) {
  if(!isDefined(level.formationlist[formationname])) {
    return;
  }

  maxcount = 31;
  assert(formationslot < maxcount && formationslot > 0, "<dev string:x8c>" + maxcount + "<dev string:xcc>" + level.formationlist[formationname]);
  function_b87ed92b349a7f11(level.formationlist[formationname], formationslot, customoffset);
}

function set_goal(formationname, goalposition) {
  if(!isDefined(level.formationlist[formationname])) {
    return;
  }

  function_c85af9dfc0791ac7(level.formationlist[formationname], goalposition);
}

function leave_formation(aitoremove) {
  if(!isarray(aitoremove)) {
    aitoremove = [aitoremove];
  }

  foreach(ai in aitoremove) {
    ai exit_formation();
  }
}

function follow_entity(formationname, ent, followdistance = 100, timestep) {
  if(!isDefined(ent)) {
    return false;
  }

  if(!isDefined(level.formationlist[formationname])) {
    return false;
  }

  leader = get_leader(formationname);

  if(isDefined(leader)) {
    leader setgoalentity(ent);
    function_d9e8c9199d57afaa(level.formationlist[formationname], followdistance);
    return true;
  }

  return false;
}

function function_4229ac53690d5052(formationname) {
  if(!isDefined(level.formationlist[formationname])) {
    return false;
  }

  leader = get_leader(formationname);

  if(isDefined(leader)) {
    leader cleargoalentity();
    return true;
  }

  return false;
}

function get_leader(formationname) {
  if(!isDefined(level.formationlist[formationname])) {
    return undefined;
  }

  return function_c016235aed58cc0(level.formationlist[formationname]);
}

function function_eab946ce0e4b65c1(formationname) {
  formationid = level.formationlist[formationname];

  if(!isDefined(formationid)) {
    return;
  }

  self function_288e5e674dcad4cc(formationid);
}

function exit_formation() {
  if(istrue(self.information)) {
    self function_8cad84107be38bc0();
    self.information = 0;
    function_1d42ca54ad3d5358();
  }
}

function private enter_formation(formationid) {
  exit_formation();
  self.information = 1;
  self function_d6e653623348abfb(formationid);
}

function private need_to_run(formationname) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xba8C\xef\xc2");
  self endon("\xbf\x95\xb30\xb9I\xab\xd8\xf9m\x03\x99C\x13\xf6X");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self notify("Z\x0f\x93u\xc1\x01_\xea\x8b\x1f\xd0\xf5\xe4\x19\xdc\xa2\xb9\xe8xV%\xa4\xdf\xeb");
  self endon("Z\x0f\x93u\xc1\x01_\xea\x8b\x1f\xd0\xf5\xe4\x19\xdc\xa2\xb9\xe8xV%\xa4\xdf\xeb");
  var_becdbc4f115366d5 = 1000;
  var_f082deebfbc21915 = 250;

  while(true) {
    leader = get_leader(formationname);

    if(!isDefined(leader)) {
      wait 1;
      continue;
    }

    disttogoal = self pathdisttogoal() - leader pathdisttogoal();

    if(getdvarint(@ "hash_96eb05fe9867a3a4", 0) == 1) {
      print3d(self.origin, self getdemeanor(), (1, 0, 0), 1, 1, 20);
      goal = self getgoalpos(3);
      utility::draw_circle(goal, var_becdbc4f115366d5, (1, 0, 0), 50);
      utility::draw_circle(goal, var_f082deebfbc21915, (0, 1, 0), 50);
    }

    idledemeanoroverride = "\x05\xb1\x1c\x86\x11\xc7";

    if(self.var_1185293b42680ed1 != idledemeanoroverride && disttogoal > var_becdbc4f115366d5) {
      self enableavoidance(1);

      if(!(isDefined(self.var_dc788d84cb687bbd) && isDefined(self.var_8adc58c57fa6753c))) {
        self.var_dc788d84cb687bbd = self.var_1185293b42680ed1;
        self.var_8adc58c57fa6753c = self.var_89db7773fe0e9170;
      }

      self.var_1185293b42680ed1 = idledemeanoroverride;
      self.var_89db7773fe0e9170 = idledemeanoroverride;
    } else if(self.var_1185293b42680ed1 == idledemeanoroverride && disttogoal < var_f082deebfbc21915) {
      self enableavoidance(0);
      self.var_1185293b42680ed1 = self.var_dc788d84cb687bbd;
      self.var_89db7773fe0e9170 = self.var_8adc58c57fa6753c;
    }

    wait 1;
  }
}

function private function_1d42ca54ad3d5358() {
  if(isDefined(self.var_dc788d84cb687bbd)) {
    self.var_1185293b42680ed1 = self.var_dc788d84cb687bbd;
  }

  if(isDefined(self.var_8adc58c57fa6753c)) {
    self.var_89db7773fe0e9170 = self.var_8adc58c57fa6753c;
  }
}

function function_ab0060ac4e88f977() {
  if(!isDefined(level.var_80ae2324ae8012e7)) {
    level.var_80ae2324ae8012e7 = 0;
  }

  returnname = "\xa3\x03A\xfes\x17O\x81\x05L\xd9\xeb\xe3" + level.var_80ae2324ae8012e7;
  level.var_80ae2324ae8012e7++;

  if(level.var_80ae2324ae8012e7 > 9999999) {
    level.var_80ae2324ae8012e7 = 0;
  }

  return returnname;
}

function function_286ead0de0186791(pathstruct) {
  if(isDefined(pathstruct.path[0]) && isDefined(pathstruct.path) && isDefined(pathstruct) && isDefined(pathstruct.path[0].script_formation_type)) {
    formationtype = pathstruct.path[0].script_formation_type;

    switch (formationtype) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
        return formationtype;
      default:
        return level.var_77c0c7ef830107da;
    }
  }

  return 3;
}

function function_f2eac3277026e5fc(pathstruct) {
  if(isDefined(pathstruct.path[0]) && isDefined(pathstruct.path) && isDefined(pathstruct) && isDefined(pathstruct.path[0].var_73362579dcc1123a)) {
    var_5ab9737504a3fa8c = tolower(pathstruct.path[0].var_73362579dcc1123a);

    switch (var_5ab9737504a3fa8c) {
      case #"hash_186d745a92c317d9":
      case #"hash_9e02cd4a0f3ca981":
        return var_5ab9737504a3fa8c;
      default:
        return "T\x1d\xd9\x0e L";
    }
  }

  return "T\x1d\xd9\x0e L";
}