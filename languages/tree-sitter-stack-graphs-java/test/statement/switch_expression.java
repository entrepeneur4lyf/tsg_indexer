class A {
  void f() {
    int x;
    switch (x) {
      //    ^ defined: 3
      case x:
      //   ^ defined: 3
      default:
        f();
      //^ defined: 2
    }
    switch (x) {
      //    ^ defined: 3
      case x -> {
        // ^ defined: 3
          f();
        //^ defined: 2
      }
    }
  }
}
