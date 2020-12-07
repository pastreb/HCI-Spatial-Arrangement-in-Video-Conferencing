import java.util.*; 

class User {
  private String name;
  private String userID;
  private String pic = null;

  public User(String n) {
    this.name = n;
    Random rand = new Random();
    int rand_int = rand.nextInt(1000000);
    this.userID = n + rand_int;
  }

  public User(String n, String p) {
    this.name = n;
    Random rand = new Random();
    int rand_int = rand.nextInt(1000000);
    this.userID = n + rand_int;
    this.pic = p;
  }

  public void setName(String name) {
    this.name = name;
  }

  public void setPic(String pic) {
    this.pic = pic;
  }

  public String getName() {
    return name;
  }

  public String getPic() {
    return pic;
  }

  public String getUserID() {
    return userID;
  }
}