#!/bin/bash

compilar() {
  g++ -std=c++11 ejercicio"$1".cpp -o ejercicio"$1".out || { echo "Error de compilación. Abortando prueba"; return 1; }
}

comparar() {
  echo '---------------------------'
  echo -n "$2.in.txt: "
  ./ejercicio"$1".out < Pruebas/Ejercicio"$1"/"$2".in.txt > Pruebas/Ejercicio"$1"/"$2".out.mine.txt || { echo "Error de ejecución"; return 1; }
  output=$(diff --strip-trailing-cr Pruebas/Ejercicio"$1"/"$2".out.mine.txt Pruebas/Ejercicio"$1"/"$2".out.txt)
  if [ -z "$output" ]; then
    echo "OK"
  else
    echo "ERROR"
  fi
}

correrPrueba() {
  echo '---------------------------'
  echo "        Ejercicio $1       "
  compilar "$1" || return 1
  for ((i = 10; i <= 1000000; i*=10)); do
    comparar "$1" $i
  done
}

pruebasEjercicio2() {
  echo '---------------------------'
  echo "        Ejercicio 2        "
  compilar 2 || return 1
  for ((i = 10; i <= 1000000; i*=10)); do
    comparar 2 2_$i
    comparar 2 5_$i
  done
}

pruebasEjercicio4() {
  echo '---------------------------'
  echo "        Ejercicio 4        "
  compilar 4 || return 1
  comparar 4 5
  comparar 4 10
  comparar 4 100
  comparar 4 1000
}

pruebasEjercicio5() {
  echo '---------------------------'
  echo "        Ejercicio 5        "
  compilar 5 || return 1
  comparar 5 5
  comparar 5 10
  comparar 5 20
  comparar 5 50
  comparar 5 100
  comparar 5 1000
}

if [ $# -eq 1 ]; then 
  if [ ! -f ejercicio"$1".cpp ]; then
    echo "No existe el archivo ejercicio$1.cpp"
    exit 1
  fi
  case $1 in
    1)
      correrPrueba 1
      ;;
    2)
      pruebasEjercicio2
      ;;
    3)
      correrPrueba 3
      ;;
    4)
      pruebasEjercicio4
      ;;
    5)
      pruebasEjercicio5
      ;;
    *)
      echo "Ejercicio inválido / no soportado"
      ;;
  esac
  exit 0
fi

if [ -f ejercicio1.cpp ]; then
  correrPrueba 1
fi

if [ -f ejercicio2.cpp ]; then
  pruebasEjercicio2
fi

if [ -f ejercicio3.cpp ]; then
  correrPrueba 3
fi

if [ -f ejercicio4.cpp ]; then
  pruebasEjercicio4
fi

if [ -f ejercicio5.cpp ]; then
  pruebasEjercicio5
fi

for ((i = 1; i <= 5; i++)); do
  rm -f Pruebas/Ejercicio$i/*.out
  rm -f Pruebas/Ejercicio$i/*.out.mine.txt
done

rm -f ./*.out
