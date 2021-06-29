FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

COPY *.sln ./
COPY Starter.Api/Starter.Api.csproj /app/Starter.Api/
COPY Starter.Core/Starter.Core.csproj /app/Starter.Core/
RUN dotnet restore 

COPY . ./
WORKDIR /app/Starter.Api
RUN dotnet publish -c Realease -o publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/Starter.Api/publish ./
ENTRYPOINT ["dotnet", "Starter.Api.dll"]

