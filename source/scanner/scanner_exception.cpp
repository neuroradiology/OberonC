/************************************************************************************************************************/
/** A Compiler for a subset of Oberon                                                                                  **/
/** authors:                                                                                                           **/
/**   ROCHA, Rodrigo Caetano de Oliveira (rcor)                                                                        **/
/**   FERREIRA, Wallace Dias                                                                                           **/
/************************************************************************************************************************/

#include "scanner_exception.h"

/**
  Implementa��o da classe ScannerException.
*/


/**
  Construtor padr�o - inicializa atributo relativo � mensagem de erro vinculada � exce��o.

  @param
     errorMessage - mensagem de erro vinculada � exce��o.
*/
ScannerException::ScannerException(string errorMessage = "") throw()
{
    this->errorMessage_ = errorMessage;
}

/**
  Destrutor da classe.
*/
ScannerException::~ScannerException() throw()
{

}

/**
  Retorna a mensagem de erro vinculada � exce��o.

  @return
     mensagem de erro vinculada � exce��o.
*/
const char* ScannerException::what() const throw()
{
    return this->errorMessage_.c_str();
}
