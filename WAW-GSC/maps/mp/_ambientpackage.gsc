/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_ambientpackage.gsc
***************************************/

init() {
  if(level.clientscripts) {
    maps\mp\_utility::registerClientSys("ambientPackageCmd");
    maps\mp\_utility::registerClientSys("ambientRoomCmd");
  }
}

tidyup_triggers(client_num) {
  amb_triggers = getEntArray("ambient_package", "targetname");

  if(isDefined(amb_triggers) && amb_triggers.size > 0) {
    for(i = 0; i < amb_triggers.size; i++) {
      trig = amb_triggers[i];

      if(isDefined(trig.in_volume) && isDefined(trig.in_volume[client_num])) {
        trig.in_volume[client_num] = 0;
      }
    }
  }
}

monitor_for_player_leave_trigger(trigPlayer, useAmbientRoom, useAmbientPackage) {
  trigPlayer endon("disconnect");
  while(trigPlayer isTouching(self)) {
    wait 0.1;
  }

  self.in_volume[trigPlayer getentitynumber()] = 0;

  if(useAmbientPackage) {
    deactivateAmbientPackage(self.script_ambientpackage, self.script_ambientpriority, trigPlayer);
  }
  if(useAmbientRoom) {
    deactivateAmbientRoom(self.script_ambientroom, self.script_ambientpriority, trigPlayer);
  }
}

player_entered_trigger(trigPlayer, useAmbientRoom, useAmbientPackage) {
  index = trigPlayer getentitynumber();

  if(!isDefined(self.in_volume[index])) {
    self.in_volume[index] = 0;
  }

  if(self.in_volume[index] == 0) {
    if(useAmbientPackage) {
      activateAmbientPackage(self.script_ambientpackage, self.script_ambientpriority, trigPlayer);
    }
    if(useAmbientRoom) {
      activateAmbientRoom(self.script_ambientroom, self.script_ambientpriority, trigPlayer);
    }

    self.in_volume[index] = 1;

    self thread monitor_for_player_leave_trigger(trigPlayer, useAmbientRoom, useAmbientPackage);
  }
}

ambientPackageTrigger() {
  useAmbientRoom = 0;
  useAmbientPackage = 0;

  if(level.clientscripts) {
    useAmbientRoom = isDefined(self.script_ambientroom);
    useAmbientPackage = isDefined(self.script_ambientpackage);
  }

  if(!isDefined(self.script_ambientpriority)) {
    self.script_ambientpriority = 1;
  }

  self.in_volume = [];

  for(;;) {
    self waittill("trigger", trigPlayer);

    self player_entered_trigger(trigPlayer, useAmbientRoom, useAmbientPackage);

    wait(0.01);
  }
}

activateAmbientPackage(package, priority, trigPlayer) {
  if(level.clientscripts) {
    notifyString = "A " + package + " " + priority;
    maps\mp\_utility::setClientSysState("ambientPackageCmd", notifyString, trigPlayer);
  }
}

deactivateAmbientPackage(package, priority, trigPlayer) {
  if(level.clientscripts) {
    notifyString = "D " + package + " " + priority;
    maps\mp\_utility::setClientSysState("ambientPackageCmd", notifyString, trigPlayer);
  }
}

activateAmbientRoom(room, priority, trigPlayer) {
  if(level.clientscripts) {
    notifyString = "A " + room + " " + priority;

    println("*** CS AR : " + room);

    maps\mp\_utility::setClientSysState("ambientRoomCmd", notifyString, trigPlayer);
  }
}

deactivateAmbientRoom(room, priority, trigPlayer) {
  if(level.clientscripts) {
    notifyString = "D " + room + " " + priority;
    maps\mp\_utility::setClientSysState("ambientRoomCmd", notifyString, trigPlayer);
  }
}