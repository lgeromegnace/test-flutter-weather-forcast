import 'package:flutter_test/flutter_test.dart';
import 'package:weather/models/session.dart';
import 'package:weather/models/user.dart';

void main() {
  test('Given a default Session then it should not be connected', () {
    Session session = Session();
    expect(session.isConnected, false);
  });

  test(
      'Given a Session without a user when setIsConnected is called with connected to true then it should not be connected',
      () {
    Session session = Session();
    session.setIsConnected(true);
    expect(session.isConnected, false);
  });

  test(
      'Given a Session without a user when setUser is called then it should be connected',
          () {
        Session session = Session();
        User user = User(name: 'Foo');
        session.setUser(user);
        expect(session.isConnected, true);
      });

  test(
      'Given a Session with a user when setIsConnected with connected to false is called then it should not be connected',
          () {
        Session session = Session();
        User user = User(name: 'Foo');
        session.setUser(user);
        session.setIsConnected(false);
        expect(session.isConnected, false);
      });
}
