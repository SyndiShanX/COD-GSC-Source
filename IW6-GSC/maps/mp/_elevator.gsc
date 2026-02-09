/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_elevator.gsc
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
  foreach(floorname, doorset in config.doors) {
    list = [];
    foreach(doorname in doorset) {
      list[list.size] = setupDoor(doorName + "left", false, config.doorMoveDist);
      list[list.size] = setupDoor(doorName + "right", true, config.doorMoveDist);
    }

    elevator.doors[floorname] = list;
  }

  elevator.trigBlock = GetEnt(config.trigBlockName, "targetname");
  AssertEx(isDefined(elevator.trigBlock), "Could not find an elevator trigger named " + config.trigBlockName);

  elevator.curFloor = "floor1";
  elevator.requestedFloor = elevator.curFloor;
  elevator.doorState = ELEVATOR_DOOR_STATE_CLOSED;

  elevator.doorOpenTime = 2.0;
  elevator.doorSpeed = config.doorMoveDist / elevator.doorOpenTime;
  elevator.moveTime = 5.0;
  elevator.autoCloseTimeout = 10.0;

  elevator.destinations = [];
  elevator.pathBlockers = [];
  elevator.buttons = getEntArray(config.buttons, "targetname");
  foreach(button in elevator.buttons) {
    button setupButton(elevator);
  }

  elevatorModels = getEntArray("elevator_models", "targetname");
  foreach(eleModel in elevatorModels) {
    eleModel LinkTo(elevator);
  }

  elevator thread elevatorThink();

  elevator thread openElevatorDoors(elevator.curFloor, false);
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
    if(isDefined(destination)) {
      elevator.destinations[self.script_label] = destination.origin;
      if(isDefined(destination.target)) {
        blocker = GetEnt(destination.target, "targetname");
        if(isDefined(blocker)) {
          elevator.pathBlockers[self.script_label] = blocker;
        }
      }
    }
  }

  self enableButton();
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

    if(self.script_label == "elevator") {
      if(elevator.curFloor == "floor1") {
        elevator.requestedFloor = "floor2";
      } else {
        elevator.requestedFloor = "floor1";
      }
    } else {
      elevator.requestedFloor = self.script_label;
    }

    elevator notify("elevator_called");
  }
}

elevatorThink() {
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
      }

      self elevatorMoveToFloor(self.requestedFloor);
      wait(0.25);
    }

    self thread openElevatorDoors(self.curFloor, false);

    self waittill("elevator_doors_open");
    foreach(button in self.buttons) {
      button enableButton();
    }
  }
}

elevatorMoveToFloor(targetFloor) {
  self playSound("scn_elevator_startup");
  self playLoopSound("scn_elevator_moving_lp");

  destinationPos = self.destinations[targetFloor];
  deltaZ = destinationPos[2] - self.origin[2];

  foreach(door in self.doors["elevator"]) {
    door MoveZ(deltaZ, self.moveTime);
  }

  self MoveZ(deltaZ, self.moveTime);

  wait(self.moveTime);

  self StopLoopSound("scn_elevator_moving_lp");
  self playSound("scn_elevator_stopping");
  self playSound("scn_elevator_beep");

  self.curFloor = self.requestedFloor;
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
    self playSound("scn_elevator_doors_opening");
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
    self playSound("scn_elevator_doors_closing");
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
  if(!isPlayer(hitEnt)) {
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