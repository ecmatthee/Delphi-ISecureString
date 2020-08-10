{
  Copyright (c) 2019 Ebert Matthee

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
}

{
  Official repository can be found at https://github.com/ecmatthee/Delphi-ISecureString
}

{
  The ISecureString Datatype provided below is based of the code provided by
  Stefan van As [https://medium.com/@svanas/creating-a-securestring-type-for-
  delphi-part-1-e7e78ed1807c] but has undergone various allterations and
  improvemenst in its current form (ex. hashing of data)
}

unit SecureString_u;

interface

uses
  IdGlobal, IdHash, IdHashMessageDigest;

type
  ISecureString = interface
    function Data: string;
    function Length: Integer;
    function Hash: string;
  end;

function NewSecureString(const S: string): ISecureString;

implementation

uses
  Windows;

{ TSecureString }

type
  TSecureString = class(TInterfacedObject, ISecureString)
  strict private
    FData: string;
  public
    constructor Create(const Value: string);
    destructor Destroy; override;
    function Data: string;
    function Length: Integer;
    function Hash: string;
  end;

constructor TSecureString.Create(const Value: string);
begin
  inherited Create;
  SetString(FData, PChar(Value), System.Length(Value));
end;

destructor TSecureString.Destroy;
var
  I: Integer;
begin
  if System.Length(FData) > 0 then
  begin
    I := PInteger(PByte(FData) - 8)^;
    if (I > -1) and (I < 2) then
      begin
        ZeroMemory(Pointer(FData), System.Length(FData) * SizeOf(Char));
      end;
  end;
  inherited Destroy;
end;

function TSecureString.Data: string;
begin
  Result := FData;
end;

function TSecureString.Length: Integer;
begin
  Result := System.Length(FData);
end;

function TSecureString.Hash: string;
  var
    hashMessageDigest5 : TIdHashMessageDigest5;
begin
  hashMessageDigest5 := nil;
    try
        hashMessageDigest5 := TIdHashMessageDigest5.Create;
        Result := IdGlobal.IndyLowerCase(hashMessageDigest5.HashStringAsHex(FData));
    finally
        hashMessageDigest5.Free;
    end;
end;

function NewSecureString(const S: string): ISecureString;
var
  I: Integer;
begin
  Result := TSecureString.Create(S);
  if System.Length(S) > 0 then
  begin
    I := PInteger(PByte(S) - 8)^;
    if (I > -1) and (I < 2) then
      begin
        ZeroMemory(Pointer(S), System.Length(S) * SizeOf(Char));
      end;
  end;
end;

end.
