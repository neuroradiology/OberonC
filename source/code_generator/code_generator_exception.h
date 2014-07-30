/************************************************************************************************************************/
/** A Compiler for a subset of Oberon                                                                                  **/
/** authors:                                                                                                           **/
/**   ROCHA, Rodrigo Caetano de Oliveira (rcor)                                                                        **/
/**   FERREIRA, Wallace Dias                                                                                           **/
/************************************************************************************************************************/

#ifndef CODE_GENERATOR_EXCEPTION_H
#define CODE_GENERATOR_EXCEPTION_H

#include <string>
#include <exception>
using namespace std;

/**
   Defini��o da classe CodeGeneratorException.

   Esta classe � utilizada para identificar exce��es geradas pelo Gerador de C�digo.
*/
class CodeGeneratorException : public exception
{

public:

    // Construtor/destrutor.
    CodeGeneratorException(string errorMessage = "") throw();
    ~CodeGeneratorException() throw();

    // Causa da exce��o.
    const char* what() const throw();

private:

    string errorMessage_;
};

#endif
