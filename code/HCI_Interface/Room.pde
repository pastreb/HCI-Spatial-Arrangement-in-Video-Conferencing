import java.util.*; 



class Room {
  private ArrayList<User> users = new ArrayList<User>();
  private ArrayList<Integer> levels = new ArrayList<Integer>();
  private ArrayList<Room> brs = new ArrayList<Room>();          //a list of all breakoutrooms
  private boolean isBreakoutroom = false;

  public Room() {
  }

  public Room(boolean b) {
    isBreakoutroom = b;
  }

  public Room(User u) {
    users.add(u);
    levels.add(1);
  }

  public Room(User u, int level) {
    users.add(u);
    levels.add(level);
  }

  public ArrayList<User> getUsers() {
    return users;
  }

  public ArrayList<Integer> getLevels() {
    return levels;
  }

  public ArrayList<Room> getBreakoutrooms() {
    return brs;
  }

  public boolean isBreakoutroom() {
    return isBreakoutroom;
  }

  public void addUser(User u, int level) {
    users.add(u);
    levels.add(level);
  }

  //will return false if userID is not in this group
  public boolean deleteUser(String userID) {
    for (int i = 0; i < users.size(); i++) {
      if (userID.equals(users.get(i).getUserID())) {
        users.remove(i);
        return true;
      }
    }
    return false;
  }

  //will return false if userID is not in this group
  public boolean changeUserLevel(String userID, int level) {
    for (int i = 0; i < users.size(); i++) {
      if (userID.equals(users.get(i).getUserID())) {
        levels.set(i, level);
        return true;
      }
    }
    return false;
  }

  public Room createBreakoutroom() {
    if (isBreakoutroom) return null;
    Room r = new Room(true);
    brs.add(r);
    return r;
  }

  //will return false if userID is not in this group
  public boolean moveUserToBreakoutroom(String userID, Room r) {
    for (int i = 0; i < users.size(); i++) {
      if (userID.equals(users.get(i).getUserID())) {
        r.addUser(users.get(i), levels.get(i));
        users.remove(i);
        levels.remove(i);
        return true;
      }
    }
    return false;
  }

  //will return false if userID is not in this group
  public boolean moveUserFromBreakoutroom(String userID, Room r) {
    for (int i = 0; i < users.size(); i++) {
      if (userID.equals(r.getUsers().get(i).getUserID())) {
        this.addUser(r.getUsers().get(i), r.getLevels().get(i));
        r.deleteUser(userID);
        return true;
      }
    }
    return false;
  }

  //returns false if room r is not a breakoutroom of this
  public boolean deleteBreakoutroom(Room r) {
    for (int i = 0; i < brs.size(); i++) {
      if (brs.get(i) == r) {
        for (int j = 0; j < r.getUsers().size(); j++) {
          this.addUser(r.getUsers().get(j), r.getLevels().get(j));
        }
        brs.remove(i);
        return true;
      }
      return false;
    }
    return false;
  }
}
