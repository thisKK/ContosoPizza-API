FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /APP

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /App
EXPOSE 80
COPY --from=build /APP/out .
ENTRYPOINT ["dotnet", "ContosoPizza.dll"]