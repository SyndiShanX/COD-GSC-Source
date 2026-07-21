/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\trigger.gsc
***********************************************/

triggerutilityinit() {
  var_0 = getEntArray("_encstr_9A551E41DAFC982C0FB366282BC35D10522CFB9F7DE211657BEB393332AB9BB0", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0)
  makeenterexittrigger(var_2);
}

makeenterexittrigger(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 thread triggerenterthink(var_1, var_2, var_3, var_4, var_5);
}

triggerenterthink(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.triggerenterents = [];
  self.triggerinsidetimes = [];
  thread triggerexitthink(var_1, var_3);

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_5);

    if(isDefined(var_4) && [[var_4]](var_5, self)) {
      continue;
    }
    var_6 = var_5 getentitynumber();

    if(!isDefined(self.triggerenterents[var_6])) {
      self notify("_encstr_8ADB0EA3C9B4ECCEB227D7AC378E95E4", var_5);

      if(isDefined(var_0))
        var_5 thread[[var_0]](var_5, self);

      if(isDefined(var_2))
        var_5 notify(var_2, self);

      self.triggerenterents[var_6] = var_5;
      self.triggerinsidetimes[var_6] = gettime();
      continue;
    }

    self.triggerinsidetimes[var_6] = gettime();
  }
}

triggerexitthink(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    waittillframeend;
    var_2 = gettime();

    foreach(var_5, var_4 in self.triggerenterents) {
      if(!isDefined(var_4)) {
        self.triggerenterents[var_5] = undefined;
        self.triggerinsidetimes[var_5] = undefined;
        continue;
      }

      if(self.triggerinsidetimes[var_5] < var_2) {
        self notify("_encstr_87A40DCB88304752E316E1677B831B", var_4);

        if(isDefined(var_0))
          var_4 thread[[var_0]](var_4, self);

        if(isDefined(var_1))
          var_4 notify(var_1, self);

        self.triggerenterents[var_5] = undefined;
        self.triggerinsidetimes[var_5] = undefined;
      }
    }

    waitframe();
  }
}