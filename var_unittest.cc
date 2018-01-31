// dados_unittest.cc: Juan A. Romero
// A sample program demonstrating using Google C++ testing framework.
//


// This sample shows how to write a more complex unit test for a class
// that has multiple member functions.
//
// Usually, it's a good idea to have one test for each method in your
// class.  You don't have to do that exactly, but it helps to keep
// your tests organized.  You may also throw in additional tests as
// needed.

#include "var.h"
#include "gtest/gtest.h"

TEST(Crupier, ConstructorParametrosDefecto) {
  Crupier c("33XX", "1");
  
  EXPECT_EQ("33XX", c.getDNI());
  EXPECT_EQ("1", c.getCodigo());
  EXPECT_EQ("", c.getNombre());
  EXPECT_EQ("", c.getApellidos());
  EXPECT_EQ("", c.getDireccion());
  EXPECT_EQ("", c.getLocalidad());
  EXPECT_EQ("", c.getProvincia());
  EXPECT_EQ("", c.getPais());
  EXPECT_EQ(", ", c.getApellidosyNombre());
}

TEST(Crupier, ConstructorParametros) {
  Crupier c("44XX", "2", "Carlos", "Gutierrez", "C/ Mesa 1", "Aguilar", "Sevilla", "España");
  
  EXPECT_EQ("44XX", c.getDNI());
  EXPECT_EQ("2", c.getCodigo());
  EXPECT_EQ("Carlos", c.getNombre());
  EXPECT_EQ("Gutierrez", c.getApellidos());
  EXPECT_EQ("C/ Mesa 1", c.getDireccion());
  EXPECT_EQ("Aguilar", c.getLocalidad());
  EXPECT_EQ("Sevilla", c.getProvincia());
  EXPECT_EQ("España", c.getPais());
  EXPECT_EQ("Gutierrez, Carlos", c.getApellidosyNombre());
}

TEST(Crupier, ConstructorCopiaDefecto) {
  Crupier p("55XX", "3", "Carlos", "Gutierrez", "C/ Mesa 1", "Aguilar", "Sevilla", "España");
  Crupier q(p);
  
  EXPECT_EQ("55XX", q.getDNI());
  EXPECT_EQ("3", q.getCodigo());
  EXPECT_EQ("Carlos", q.getNombre());
  EXPECT_EQ("Gutierrez", q.getApellidos());
  EXPECT_EQ("C/ Mesa 1", q.getDireccion());
  EXPECT_EQ("Aguilar", q.getLocalidad());
  EXPECT_EQ("Sevilla", q.getProvincia());
  EXPECT_EQ("España", q.getPais());
  EXPECT_EQ("Gutierrez, Carlos", q.getApellidosyNombre());
}

TEST(Crupier, OperadorIgual) {
  Crupier p("66XX", "4", "Carlos", "Gutierrez", "C/ Mesa 1", "Aguilar", "Sevilla", "España");
  Crupier q("77FF", "5");
  q=p;
  EXPECT_EQ("66XX", q.getDNI());
  EXPECT_EQ("4", q.getCodigo());
  EXPECT_EQ("Carlos", q.getNombre());
  EXPECT_EQ("Gutierrez", q.getApellidos());
  EXPECT_EQ("C/ Mesa 1", q.getDireccion());
  EXPECT_EQ("Aguilar", q.getLocalidad());
  EXPECT_EQ("Sevilla", q.getProvincia());
  EXPECT_EQ("España", q.getPais());
  EXPECT_EQ("Gutierrez, Carlos", q.getApellidosyNombre());
}
