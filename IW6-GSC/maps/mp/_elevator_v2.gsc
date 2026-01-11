/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_elevator_v2.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

ELEVATOR_DOOR_TIME = 2;
ELEVATOR_FLOOR_MOVE_TIME = 5;
ELEVATOR_AUTOCLOSE_TIMEOUT = 10;

ELEVATOR_DOOR_STATE_CLOSED = 0;
ELEVATOR_DOOR_STATE_OPENING = 1;
ELEVATOR_DOOR_STATE_OPEN = 2;
ELEVATOR_DOOR_STATE_CLOSING = 3;

init_elevator(config) {
  elevator = GetEnt(config.name, "targetname");
  AssertEx(isDefined(elevator), "Could not find an elevator entity named " + config.name);
  elevator.unresolved_collision_func = ::handleUnreslovedCollision;

  elevator.doors = [];
  if(isDefined(config.doors)) {
    foreach(floorname, doorset in config.doors) {
      list = [];
      foreach(doorname in doorset) {
        list[list.size] = setupDoor(doorName + "left", false, config.doorMoveDist);
        list[list.size] = setupDoor(doorName + "right", true, config.doorMoveDist);
      }

      elevator.doors[floorname] = list;
    }

    if(isDefined(config.doorOpenTime)) {
      elevator.doorOpenTime = config.doorOpenTime;
    } else {
      elevator.doorOpenTime = ELEVATOR_DOOR_TIME;
    }

    elevator.doorSpeed = config.doorMoveDist / elevator.doorOpenTime;

    if(isDefined(config.autoCloseTimeout)) {
      elevator.autoCloseTimeout = config.autoCloseTimeout;
    } else {
      elevator.autoCloseTimeout = ELEVATOR_AUTOCLOSE_TIMEOUT;
    }

    elevator.trigBlock = GetEnt(config.trigBlockName, "targetname");
    AssertEx(isDefined(elevator.trigBlock), "Could not find an elevator trigger named " + config.trigBlockName);

    if(isDefined(config.autoCloseTimeout)) {
      elevator.autoCloseTimeout = config.autoCloseTimeout;
    } else {
      elevator.autoCloseTimeout = ELEVATOR_AUTOCLOSE_TIMEOUT;
    }

    elevator.doorOpenSfx = config.doorOpenSfx;
    elevator.doorCloseSfx = config.doorCloseSfx;
  }

  if(isDefined(config.moveTime)) {
    elevator.moveTime = config.moveTime;
  } else {
    elevator.moveTime = ELEVATOR_FLOOR_MOVE_TIME;
  }

  elevator.destinations = [];
  elevator.pathBlockers = [];
  elevator.buttons = getEntArray(config.buttons, "targetname");
  foreach(button in elevator.buttons) {
    button setupButton(elevator);
  }

  destinationStructs = getstructarray(config.destinations, "targetname");
  foreach(destination in destinationStructs) {
    elevator setupDestination(destination);
  }
  elevator.destinationNames = config.destinationNames;

  elevator.curFloor = config.destinationNames[0];
  elevator.requestedFloor = elevator.curFloor;
  elevator.doorState = ELEVATOR_DOOR_STATE_CLOSED;

  if(isDefined(config.models)) {
    elevatorModels = getEntArray(config.models, "targetname");
    if(isDefined(elevatorModels)) {
      foreach(eleModel in elevatorModels) {
        eleModel LinkTo(elevator);
      }
    }
  }

  elevator thread elevatorThink();

  if(elevator.doors.size > 0) {
    elevator thread openElevatorDoors(elevator.curFloor, false);
  }

  elevator.startSfx = config.startSfx;
  elevator.stopSfx = config.stopSfx;
  elevator.loopSfx = config.loopSfx;
  elevator.beepSfx = config.beepSfx;

  elevator.onMoveCallback = config.onMoveCallback;
  elevator.onArrivedCallback = config.onArrivedCallback;

  return elevator;
}

setupDoor(doorName, isRightSide, moveDistance) {
  door = GetEnt(doorName, "targetname");
  if(isDefined(door)) {
    door.closePos = door.origin;
    if(isDefined(door.target)) {
      targetStruct = getstruct(door.target, "targetname");
      door.openPos = targetStruct.origin;
    } else {
      offset = anglesToForward(door.angles) * moveDistance;

      door.openPos = door.origin + offset;
    }

    return door;
  } else {
    AssertEx(isDefined(door), "Could not find an elevator door entity named " + doorName);
    return;
  }
}

setupButton(elevator) {
  self.owner = elevator;

  if(isDefined(self.target)) {
    destination = getstruct(self.target, "targetname");
    self setupDestination(destination);
  }

  self enableButton();
}

setupDestination(destination) {
  if(isDefined(destination)) {
    self.destinations[destination.script_label] = destination.origin;
    if(isDefined(destination.target)) {
      blocker = GetEnt(destination.target, "targetname");
      if(isDefined(blocker)) {
        self.pathBlockers[destination.script_label] = blocker;
      }
    }
  }
}

enableButton() {
  self SetHintString(&"MP_ELEVATOR_USE");
  self MakeUsable();

  self thread buttonThink();
}

disableButton() {
  self MakeUnusable();
}

buttonThink() {
  elevator = self.owner;
  elevator endon("elevator_busy");

  while(true) {
    self waittill("trigger");

    if(!isDefined(self.script_label) || self.script_label == "elevator") {
      if(elevator.curFloor == elevator.destinationNames[0]) {
        elevator.requestedFloor = elevator.destinationNames[1];
      } else {
        elevator.requestedFloor = elevator.destinationNames[0];
      }
    } else {
      elevator.requestedFloor = self.script_label;
    }

    elevator notify("elevator_called");
  }
}

elevatorThink() {
  hasDoors = self.doors.size > 0;

  while(true) {
    self waittill("elevator_called");

    foreach(button in self.buttons) {
      button disableButton();
    }

    if(self.curFloor != self.requestedFloor) {
      if(self.doorState != ELEVATOR_DOOR_STATE_CLOSED) {
        self notify("elevator_stop_autoclose");
        self thread closeElevatorDoors(self.curFloor);
        self waittill("elevator_doors_closed");
      } else if(!hasDoors) {
        self elevatorBlockPath(self.curFloor);
      }

      self elevatorMoveToFloor(self.requestedFloor);
      wait(0.25);
    }

    if(hasDoors) {
      self thread openElevatorDoors(self.curFloor, false);
      self waittill("elevator_doors_open");
    } else {
      self elevatorClearPath(self.curFloor);
    }

    foreach(button in self.buttons) {
      button enableButton();
    }
  }
}

elevatorMoveToFloor(targetFloor) {
  destinationPos = self.destinations[targetFloor];
  deltaZ = destinationPos[2] - self.origin[2];

  if(isDefined(self.doors["elevator"])) {
    foreach(door in self.doors["elevator"]) {
      door MoveZ(deltaZ, self.moveTime);
    }
  }

  self MoveZ(deltaZ, self.moveTime);

  if(isDefined(self.onMoveCallback)) {
    self thread[[self.onMoveCallback]](targetFloor);
  }

  wait(self.moveTime);

  if(isDefined(self.beepSfx)) {
    self playSound(self.beepSfx);
  }

  self.curFloor = self.requestedFloor;

  if(isDefined(self.onArrivedCallback)) {
    self thread[[self.onArrivedCallback]](self.curFloor);
  }
}

openElevatorDoors(floorName, autoClose) {
  doorset = self.doors[floorName];

  self.doorState = ELEVATOR_DOOR_STATE_OPENING;

  door = doorset[0];
  doorDest = (door.openPos[0], door.openPos[1], door.origin[2]);
  moveDelta = doorDest - door.origin;
  moveDist = Length(moveDelta);

  movetime = moveDist / self.doorSpeed;
  accelTime = 0.25;
  if(moveTime == 0.0) {
    moveTime = 0.05;
    accelTime = 0.0;
  } else {
    self playSound(self.doorOpenSfx);
    accelTime = min(accelTime, moveTime);
  }

  foreach(door in doorset) {
    door MoveTo((door.openPos[0], door.openPos[1], door.origin[2]), movetime, 0.0, accelTime);
  }
  wait(movetime);

  self.doorState = ELEVATOR_DOOR_STATE_OPEN;

  self notify("elevator_doors_open");

  self elevatorClearPath(floorName);

  if(autoClose) {
    self thread elevatorDoorsAutoClose();
  }
}

closeElevatorDoors(floorName) {
  self endon("elevator_close_interrupted");

  self thread watchCloseInterrupted(floorName);

  doorset = self.doors[floorName];

  self.doorState = ELEVATOR_DOOR_STATE_CLOSING;

  door = doorset[0];
  doorDest = (door.closePos[0], door.closePos[1], door.origin[2]);
  moveDelta = doorDest - door.origin;
  moveDist = Length(moveDelta);

  if(moveDist != 0.0) {
    movetime = moveDist / self.doorSpeed;
    foreach(door in doorset) {
      door MoveTo((door.closePos[0], door.closePos[1], door.origin[2]), movetime, 0.0, 0.25);
    }
    self playSound(self.doorCloseSfx);
    wait(movetime);
  }

  self.doorState = ELEVATOR_DOOR_STATE_CLOSED;

  self elevatorBlockPath(floorName);

  self notify("elevator_doors_closed");
}

watchCloseInterrupted(floorName) {
  self endon("elevator_doors_closed");

  nothingBlocking = true;
  foreach(character in level.characters) {
    if(character isTouchingTrigger(self.trigBlock)) {
      nothingBlocking = false;
      break;
    }
  }

  if(nothingBlocking) {
    self.trigBlock waittill("trigger");
  }

  self notify("elevator_close_interrupted");

  self openElevatorDoors(floorName, true);
}

isTouchingTrigger(trigger) {
  return (IsAlive(self) && self IsTouching(trigger));
}

elevatorDoorsAutoClose() {
  self endon("elevator_doors_closed");
  self endon("elevator_stop_autoclose");

  wait(self.autoCloseTimeout);

  self closeElevatorDoors(self.curFloor);
}

handleUnreslovedCollision(hitEnt) {
  if(!IsPlayer(hitEnt)) {
    hitEnt DoDamage(1000, hitEnt.origin, self, self, "MOD_CRUSH");
  }
}

elevatorClearPath(floorName) {
  blocker = self.pathBlockers[floorName];
  if(isDefined(blocker)) {
    blocker ConnectPaths();
    blocker Hide();
    blocker NotSolid();
  }
}

elevatorBlockPath(floorName) {
  blocker = self.pathBlockers[floorName];
  if(isDefined(blocker)) {
    blocker Show();
    blocker Solid();
    blocker DisconnectPaths();
  }
}