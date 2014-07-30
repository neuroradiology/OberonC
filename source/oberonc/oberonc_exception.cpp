/************************************************************************************************************************/
/** A Compiler for a subset of Oberon                                                                                  **/
/** authors:                                                                                                           **/
/**   ROCHA, Rodrigo Caetano de Oliveira (rcor)                                                                        **/
/**   FERREIRA, Wallace Dias                                                                                           **/
/************************************************************************************************************************/

#include "oberonc_exception.h"

/**
  Implementa��o da classe de exce��es para o Oberon-0 Compiler.
*/

/**
  Construtor padr�o - inicializa atributo relativo � mensagem de erro vinculada � exce��o.

  @param
     errorMessage - mensagem de erro vinculada � exce��o.
*/
OberonC_Exception::OberonC_Exception(string errorMessage) throw()
{
    this->errorMessage_ = errorMessage;
}

/**
  Destrutor da classe.
*/
OberonC_Exception::~OberonC_Exception() throw()
{

}

/**
  Retorna a mensagem de erro vinculada � exce��o.

  @return
     mensagem de erro vinculada � exce��o.
*/
const char* OberonC_Exception::what() const throw()
{
    return this->errorMessage_.c_str();
}
