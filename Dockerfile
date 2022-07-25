FROM node:alpine



# Create app directory
WORKDIR /usr/src/app

# add node_modules folder to $PATH
ENV PATH /app/node_modules/.bin:PATH

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY ./package.json /app/

RUN npm install -g
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

# Build the final image using a nginx web server
FROM nginx:alpine
COPY --from=build /app/build /usr/share/ngnix/html

# need this to make React work properly
RUN rm /etc/nginx/conf.d/default.conf 
COPY nginx/nginx.conf /etc/nginx/conf.d 

EXPOSE 8080
CMD [ "npm", "start" ]
