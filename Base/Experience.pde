class Experience {
  //variables
  int level  = 0;

  float exp    = 0;
  float target = 0;
  float increment = 0.4;

  //experience values
  float[] xpValues = {0.1, 0.2, 0.5, 1, 2};
  //basic, metals, gems,

  //--------------------------------------------------------------------------------------------------
  //constructor
  Experience() {

  }

  //--------------------------------------------------------------------------------------------------
  //methods
  void checkExperience() {
    if (exp >= target) {
      exp -= target;
      target = newTarget();
      level++;
    }
  }

  float newTarget() {  //calculate new target for next XP-level
    return target + target * increment;
  }

  //--------------------------------------------------------------------------------------------------
  //gain experience
  void gainXP(String arg) {
    switch(arg) {
    case "basic":
      exp += xpValues[0];
      break;

    case "metal":
      exp += xpValues[1];
      break;

    case "gems":
      exp += xpValues[2];
      break;

    default:
      //default result
      break;
    }
    checkExperience();
  }

  //--------------------------------------------------------------------------------------------------
  //get methods
  int getLevel() {
    return level;
  }

  float getXPPercent() {
    float percent;

    percent = this.exp / target;

    return percent;
  }
}