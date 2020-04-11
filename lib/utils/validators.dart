String validator(String input){ 
  if(input.isEmpty || input.length < 6)
      return 'Favor de completar campo con almenos 6 digitos';
    
    return null;
}