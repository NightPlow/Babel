//
// Created by Quentin Liardeaux on 10/4/19.
//

#include "ServerCommunication.hpp"

ServerCommunication::ServerCommunication(const std::string &ipAddress, int port) :
        context_()
        , socket_(BoostTcp::socket(context_))
        , ipAddress_(ipAddress)
        , port_(port)
{
}

ServerCommunication::~ServerCommunication()
{
    socket_.close();
}

void ServerCommunication::start()
{
    socket_.connect(BoostTcp::endpoint(
            boost::asio::ip::address::from_string(ipAddress_), port_));
}

void ServerCommunication::sendRequest(boost::shared_ptr<boost::mutex> mutex, boost::shared_ptr<std::queue<Message>> queue)
{
    Message message;

    while (true) {
        mutex->lock();
        if (queue->size() <= 0) {
            mutex->unlock();
            continue;
        }
        if (queue->front().getId() == -1) {
            mutex->unlock();
            break;
        }
        write(queue->front());
        queue->pop();
        mutex->unlock();
    }
}

void ServerCommunication::write(Message &message)
{
    socket_.send(boost::asio::buffer(message.getHeaderRaw(), HEADER_SIZE));
    socket_.send(boost::asio::buffer(message.getPayload(), message.getPayloadSize()));
}