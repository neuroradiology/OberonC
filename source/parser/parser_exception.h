/************************************************************************************************************************/
/** A Compiler for a subset of Oberon                                                                                  **/
/** authors:                                                                                                           **/
/**   ROCHA, Rodrigo Caetano de Oliveira (rcor)                                                                        **/
/**   FERREIRA, Wallace Dias                                                                                           **/
/************************************************************************************************************************/

#ifndef PARSER_EXCEPTION_H
#define PARSER_EXCEPTION_H

#include <string>
#include <exception>
using namespace std;

/**
   Defini��o da classe ParserException.

   Esta classe � utilizada para identificar exce��es geradas pelo Parser ao
   manipular um arquivo de c�digo.
*/
class ParserException : public exception
{

public:

    // Construtor/destrutor.
    ParserException(string errorMessage = "") throw();
    ~ParserException() throw();

    // Causa da exce��o.
    const char* what() const throw();

private:

    string errorMessage_;
};

#endif
