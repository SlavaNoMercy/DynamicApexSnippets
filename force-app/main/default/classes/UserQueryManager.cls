public with sharing class UserQueryManager {
    public static User getUserByUsername(String username) {
        
        if (String.isBlank(username)) {
            return null;
        }

        List<User> user = [
            SELECT Id, Name, LastName
            FROM User
            WHERE Username = :username//'adani@sqwww1.com'
        ];

        return user.isEmpty() ? null : user[0];
    }
}