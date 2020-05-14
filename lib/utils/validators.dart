String validator(String input, int length)
{ 
  if(input.isEmpty || input.length < length)
      return 'Favor de completar campo con almenos '+ length.toString() + ' digitos';
  
   return null;
    
}