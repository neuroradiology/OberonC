/************************************************************************************************************************/
/** A Compiler for a subset of Oberon                                                                                  **/
/** authors:                                                                                                           **/
/**   ROCHA, Rodrigo Caetano de Oliveira (rcor)                                                                        **/
/**   FERREIRA, Wallace Dias                                                                                           **/
/************************************************************************************************************************/

#ifndef OBERONC_EXCEPTION_H
#define OBERONC_EXCEPTION_H

#include <string>
#include <exception>

using namespace std;

/**
  Defini��o da classe OberonC_Exception.

  Esta classe � utilizada para identificar exce��es lan�adas pela classe principal
  do Oberon-0 Compiler.

  @see OberonC
*/
class OberonC_Exception : public exception
{

public:

    // Construtor/destrutor.
    OberonC_Exception(string errorMessage = "") throw();
    ~OberonC_Exception() throw();

    // Causa da exce��o.
    const char* what() const throw();

private:

    string errorMessage_;
};

#endif
